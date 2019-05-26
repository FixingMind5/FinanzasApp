//
//  AddViewModel.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 4/26/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit
import FirebaseFirestore
import PlatziFinanzasCore
import FirebaseAuth

class AddTransactionViewModel {
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    func add(name: String, description: String, value: String){
        guard let value = Float(value) else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let transaction = PlatziFinanzasCore.Transaction(
                            transName: name,
                            transValue: value,
                            transDate: Date(),
                            transCategory: .expend,
                            transDescription: description
        )
        
        guard var data = transaction.data() else {
            return
        }
        
        data["ownerId"] = uid
        
        db.collection("transactions").addDocument(data: data) { (error) in
            print(error?.localizedDescription ?? "Object added")
            //Notificaciñón de que se agregaron datos
            NotificationCenter.default.post(name: Notification.Name("AddedData"), object: nil)
        }
    }
}
