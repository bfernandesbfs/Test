//
//  BUIStepper.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class BUIStepper: UIControl {
    
    public var autoRepeat: Bool = true {
        didSet {
            if autoRepeatInterval <= 0 {
                autoRepeat = false
            }
        }
    }
    
    public var autoRepeatInterval: TimeInterval = 0.08 {
        didSet {
            if autoRepeatInterval <= 0 {
                autoRepeatInterval = 0.10
                autoRepeat = false
            }
        }
    }
    
    public var wraps: Bool = false
    
    public var minimumValue: Double = 0 {
        willSet {
            assert(newValue < maximumValue, "\(type(of: self)): minimumValue must be less than maximumValue.")
        }
    }
    
    public var maximumValue: Double = 100 {
        willSet {
            assert(newValue > minimumValue, "\(type(of: self)): maximumValue must be greater than minimumValue.")
        }
    }
    
    public var decrementStepValue: Double = 1 {
        willSet {
            assert(newValue > 0, "\(type(of: self)): decrementStepValue must be greater than zero.")
        }
    }
    
    public var incrementStepValue: Double = 1 {
        willSet {
            assert(newValue > 0, "\(type(of: self)): incrementStepValue must be greater than zero.")
        }
    }
    
    // MARK: - Accessing the Stepper’s Value
    
    public var value: Double = 0 {
        didSet {
            guard value != oldValue else { return }
            
            if value < minimumValue {
                value = minimumValue
            } else if value > maximumValue {
                value = maximumValue
            }
            
            sendActions(for: .valueChanged)
            valueChangedCallback?(self)
        }
    }
    
    // MARK: - Callbacks
    
    public var valueChangedCallback: ((BUIStepper) -> Void)?
    
    public var decrementCallback: ((BUIStepper) -> Void)?
    
    public var incrementCallback: ((BUIStepper) -> Void)?
    
    public var maxValueClampedCallback: ((BUIStepper) -> Void)?
    
    public var minValueClampedCallback: ((BUIStepper) -> Void)?
    
    // MARK: - Private Variables
    
    private var longPressTimer: Timer?
    
    // MARK: - Initialization
    
    public let decrementButton: UIButton
    public let incrementButton: UIButton
    
    public init(decrementButton: UIButton, incrementButton: UIButton) {
        self.decrementButton = decrementButton
        self.incrementButton = incrementButton
        
        super.init(frame: CGRect.zero)
        
        self.decrementButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        self.incrementButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        
        for button in [self.decrementButton, self.incrementButton] {
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
            button.addGestureRecognizer(longPressRecognizer)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Decrementing / Incrementing
    
    public func decrementValue() {
        switch value - decrementStepValue {
        case let x where wraps && x < minimumValue:
            value = maximumValue
        case let x where x >= minimumValue:
            value = x
            decrementCallback?(self)
        default:
            endLongPress()
            minValueClampedCallback?(self)
        }
    }
    
    public func incrementValue() {
        switch value + incrementStepValue {
        case let x where wraps && x > maximumValue:
            value = minimumValue
        case let x where x <= maximumValue:
            value = x
            incrementCallback?(self)
        default:
            endLongPress()
            maxValueClampedCallback?(self)
        }
    }
    
    // MARK: - User Interaction
    
    public func didLongPress(_ sender: UIGestureRecognizer) {
        guard autoRepeat else {
            return
        }
        
        switch sender.state {
        case .began: startLongPress(sender)
        case .ended, .cancelled, .failed: endLongPress()
        default: break
        }
    }
    
    private func startLongPress(_ sender: UIGestureRecognizer) {
        guard longPressTimer == nil else { return }
        
        longPressTimer = Timer.scheduledTimer(
            timeInterval: autoRepeatInterval,
            target: self,
            selector: sender.view == incrementButton ? #selector(incrementValue) : #selector(decrementValue),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func endLongPress() {
        guard let timer = longPressTimer else { return }
        
        timer.invalidate()
        longPressTimer = nil
    }
}

