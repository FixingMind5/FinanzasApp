//
//  AddViewController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 4/26/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var transactionNameLabel: UITextField!
    @IBOutlet weak var transactionDescriptionLabel: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    private var viewModel = AddTransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        valueTextField.becomeFirstResponder()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func addTransaction(_ sender: UIButton) {
        viewModel.add(
            name: transactionNameLabel.text ?? "new add",
            description: transactionDescriptionLabel.text ?? "",
            value: valueTextField.text ?? "0"
        )
        
        valueTextField.resignFirstResponder()
        tabBarController?.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
