//
//  CartViewController.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    public var viewModel: CartViewProtocol!
    
    fileprivate var sectionView: CartSectionView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = CartViewModel(target: self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteItemButtonPressed(_ sender: UIButton, forEvent event: UIEvent) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView!)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition) {
            viewModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            didUpdate()
        }
    }
}

extension CartViewController: ControllerDelegate {
    
    public func didUpdate() {
        tableView.reloadData()
    }
    
    public func didFail(message: String) {
        print(message)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = sectionView else {
            let view = CartSectionView(frame: CGRect(x:0.0, y:0.0, width:tableView.frame.width, height:60.0))
            view.subTotal = viewModel.subTotal
            sectionView = view
            return view
        }
        
        view.frame = CGRect(x:0.0, y:0.0, width:tableView.frame.width, height:60.0)
        view.subTotal = viewModel.subTotal
        return view
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.data = viewModel.row(at: indexPath.row)
        cell.didChange = { [weak self] value in
            self?.viewModel.change(at: indexPath.row, quantity: Int(value)!)
            self?.sectionView.subTotal = self?.viewModel.subTotal
        }
        return cell
    }
    
}
