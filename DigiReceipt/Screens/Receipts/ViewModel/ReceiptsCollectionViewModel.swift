//
//  ReceiptsCollectionViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import Foundation
import Combine
import Observation

@Observable class ReceiptsCollectionViewModel {
    
    var receiptsCollections = [ReceiptsCollectionModel]()
    
    init(loadFakeData: Bool = false){
        
        
        if loadFakeData {
            self.loadFakeData()
        }
    }

    
    init(recieptCollections: [ReceiptModel]){
        self.receiptsCollections = receiptsCollections
    }

    
    func loadFakeData() {
        
        let receipts = (1...10).map { index in
            let products = (1...10).map { index2 in
                ProductRowModel(name: "Item \(index2)", price: 1.0 * Double(index2 + index))
            }
            
            return ReceiptModel(vendor: "Vendor \(index)", products: products, paymentMethod: "Visa", category: "Food")
        }
        let receiptsCollections = [ReceiptsCollectionModel(collection_name: "July 2024", receipts: receipts)]
        
        self.receiptsCollections = receiptsCollections
    }
}
