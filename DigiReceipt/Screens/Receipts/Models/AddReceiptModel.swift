//
//  AddReceiptModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-16.
//

import Foundation
struct AddReceiptModel {
    var vendor: String
    var date: Date = .now
    var products: [ProductModel]
    var totalAmount: Double
    var paymentMethod: String
    var categoryId: String?
}
