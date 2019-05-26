//
//  TransactionsViewModel.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 4/25/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import Foundation
import FirebaseFirestore
import PlatziFinanzasCore
import FirebaseAuth

protocol TransactionsViewModelDelegate {
    func reloadData()
}

class TransactionsViewModel {
    private var items: [PlatziFinanzasCore.Transaction] = []
    
    private var db: Firestore {
        let db = Firestore.firestore()
        let settings = db.settings
        
        //settings.areTimestampsInSnapshotsEnabled = true
        settings.isPersistenceEnabled = true
        db.settings = settings
        
        return db
    }
    
    var numbreOfItems: Int {
        return items.count
    }
    
    var delegate: TransactionsViewModelDelegate?
    
    init() {
        getData()
        //Notificación de aue la vista ya tiene los datos
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: Notification.Name("AddedData"), object: nil)
    }
  
    @objc private func getData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("transactions")
            .whereField("ownerId", isEqualTo: uid)
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] (snapshot, error) in
                
                //se va a asegurar de que esta clase exista, entonces el código de abajo se ejecutará
                guard let self = self else { return }
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.items.removeAll()
                
                try? snapshot?.documents.forEach({ (snapshot) in
                    let json = snapshot.data()
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    
                    guard let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData) else {
                        
                        return
                    }
                    
                    transaction.fireBaseID = snapshot.documentID
                    self.items.append(transaction)
                })
                
                self.delegate?.reloadData()
        }
        
    }
    
    func item(at indexPath: IndexPath) -> TransactionViewModel {
        return TransactionViewModel(transaction: items[indexPath.row])
    }
    
    func remove(at indexPath: IndexPath) {
        let item = items.remove(at: indexPath.row)
        
        guard let firebaseId = item.fireBaseID else { return }
        
        db.collection("transactions").document(firebaseId).delete()
    }
    
}

class TransactionViewModel {
    private var transaction: PlatziFinanzasCore.Transaction
    
    var name: String {
        return transaction.transName
    }
    
    var value: String {
        return transaction.transValue.currency()
    }
    
    var date: String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: transaction.transDate)
    }
    
    var time: String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm"
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: transaction.transDate)
    }
    
    var description: String {
        return transaction.transDescription
    }
    
    init(transaction: PlatziFinanzasCore.Transaction) {
        self.transaction = transaction
    }
}
