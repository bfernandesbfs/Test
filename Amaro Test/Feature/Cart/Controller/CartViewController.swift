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
    @IBOutlet var emptyView: UIView!
    
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
            if viewModel.count() == 0 {
                let section: IndexSet = [0]
                tableView.deleteSections(section, with: .left)
            }
            else {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            didUpdate()
        }
    }
}

extension CartViewController: ControllerDelegate {
    
    public func didUpdate() {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeForwards
        transition.duration = 0.3
        
        transition.isRemovedOnCompletion = false
        tableView.layer.add(transition, forKey: "transitionFade")
        tableView.reloadData()
    }
    
    public func didFail(message: String) {
    
        let alertController = UIAlertController(title: String.localized(id: "label.alert.info"), message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: String.localized(id: "label.alert.Ok") ,style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView = nil
        if viewModel.count() == 0 {
            tableView.backgroundView = emptyView
            return 0 
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CartSectionView(frame: CGRect(x:0.0, y:0.0, width:tableView.frame.width, height:60.0))
        view.subTotal = viewModel.subTotal
        sectionView = view
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
