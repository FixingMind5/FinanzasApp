//
//  TransactionTableViewCell.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 5/6/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionName: UILabel!
    @IBOutlet weak var transactionDescription: UILabel!
    @IBOutlet weak var transactionValue: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionTime: UILabel!
    
    var viewModel : TransactionViewModel! {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpView() {
        transactionName.text = viewModel.name
        transactionValue.text = viewModel.value
        transactionDescription.text = viewModel.description
        transactionDate.text = viewModel.date
        transactionTime.text = viewModel.time
    }

}
