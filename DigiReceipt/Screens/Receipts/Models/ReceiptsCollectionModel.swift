//
//  GroupedReceiptsModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import Foundation
import Observation

struct ReceiptsCollectionModel: Identifiable, Hashable  {
    var id = UUID()
    var collection_name: String
    var receipts: [ReceiptModel]
    
    static func == (lhs: ReceiptsCollectionModel, rhs: ReceiptsCollectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
