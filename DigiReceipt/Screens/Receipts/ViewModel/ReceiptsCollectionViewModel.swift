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
    
    var receiptsCollections = [CollectionModel]()
    
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
                ProductModel(name: "Item \(index2)", price: 1.0 * Double(index2 + index))
            }
            
            return ReceiptModel(vendor: "Vendor \(index)", products: products, paymentMethod: "Visa", categoryId: "Food")
        }
        let receiptsCollections = [CollectionModel(collection_name: "July 2024", receipts: receipts), CollectionModel(collection_name: "August 2024", receipts: receipts)]
        
        self.receiptsCollections = receiptsCollections
    }
    enum AnimationID {
        case vendor
        
        var animID: String {
            switch self {
            case .vendor:
                return "vendor"
                
            }
        }
    }
}
