//
//  CollectionModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import Foundation
import Observation

struct CollectionModel: Identifiable, Hashable  {
    var id = UUID()
    var collection_name: String
    var receipts: [ReceiptModel]
    var expanded: Bool = true
    
    static func == (lhs: CollectionModel, rhs: CollectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
