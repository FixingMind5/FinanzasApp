//
//  TransactionsViewController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 3/26/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit
//import Lottie

class TransactionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate( set ) lazy var emptyStateView: UIView = {
        guard let view = Bundle.main.loadNibNamed("EmptyState", owner: nil, options: [:])?.first as? UIView else {
            return UIView()
        }
        return view
    }()
    
    private var viewModel = TransactionsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        viewModel.delegate = self
        
        let cell = UINib(nibName: "TransactionsCell", bundle: Bundle.main)
        tableView.register(cell, forCellReuseIdentifier: "cell")
    }
}

extension TransactionsViewController: TransactionsViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    
}

extension TransactionsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> [UITableViewRowAction] {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, index) in
            self?.viewModel.remove(at: index)
            tableView.deleteRows(at: [index], with: .fade)
        }
        
        return [delete]
    }
    
}

extension TransactionsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numbreOfItems
        tableView.backgroundView = count == 0 ? emptyStateView : nil
        tableView.separatorStyle = count == 0 ? .none : .singleLine
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.item(at: indexPath)
        return cell
    }
}
