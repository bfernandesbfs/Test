//
//  ImageRequest.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (Response) -> Void

/// Data loading completion closure.
public typealias ImageDataLoadingCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/// Data loading progress closure.
public typealias ImageDataLoadingProgress = (_ completed: Int64, _ total: Int64) -> Void

public class ImageRequest: NSObject, URLSessionDataDelegate {
    
    public class var shared: ImageRequest {
        struct Instance {
            static let session = ImageRequest()
        }
        return Instance.session
    }
    
    fileprivate fileprivate(set) var session: Foundation.URLSession!
    fileprivate var handlers = [URLSessionTask: DataTaskHandler]()
    fileprivate var lock = NSRecursiveLock()
    fileprivate var task:URLSessionTask!
    
    public override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: (200 * 1024 * 1024), diskPath: "amaro-test-images")
        self.session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    public func download(_ url:String, progress: @escaping ImageDataLoadingProgress, completion: @escaping NetworkCompletion) {
        requestWithMethod(url, progress: progress, completion: completion)
    }
    
    public func cancelTask(){
        if task != nil {
            task.cancel()
        }
    }
    
    public func invalidate() {
        session.invalidateAndCancel()
    }

    public func removeAllCachedImages() {
        session.configuration.urlCache?.removeAllCachedResponses()
    }
    
    fileprivate func requestWithMethod(_ path:String, progress: @escaping ImageDataLoadingProgress, completion: @escaping NetworkCompletion) {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        task = session.dataTask(with: request)
        lock.lock()
        handlers[task] = DataTaskHandler(progress: progress, completion: completion)
        lock.unlock()
        
        task.resume()
    }
    
    // MARK: NSURLSessionDataDelegate
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        lock.lock()
        if let handler = handlers[dataTask] {
            handler.data.append(data)
            handler.progress(dataTask.countOfBytesReceived, dataTask.countOfBytesExpectedToReceive)
        }
        lock.unlock()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        lock.lock()
        if let handler = handlers[task] {
            let wrappedResponse = Response(data: handler.data as Data!, response: task.response, error: error as NSError?)
            handler.completion(wrappedResponse)
            handlers[task] = nil
        }
        lock.unlock()
    }
}

private class DataTaskHandler {
    let data = NSMutableData()
    let progress: ImageDataLoadingProgress
    let completion: NetworkCompletion
    
    init(progress: @escaping ImageDataLoadingProgress, completion: @escaping NetworkCompletion) {
        self.progress = progress
        self.completion = completion
    }
}
