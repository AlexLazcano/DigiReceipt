//
//  ReceiptModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation

struct ProductRowModel {
    var id = UUID()
    var name: String
    var price: Double
}

struct ReceiptModel: Identifiable, Hashable {
    var id = UUID()
    var vendor: String
    var date: Date = .now
    var products: [ProductRowModel]
    var totalAmount: Double
    var paymentMethod: String
    var category: String?
    
    
    init(vendor: String, products: [ProductRowModel], paymentMethod: String, category: String){
        
        let total = products.reduce(0) { sum, product in
            sum + product.price
        }
        self.products = products
        self.vendor = vendor
        self.totalAmount = total
        self.paymentMethod = paymentMethod
        self.category = category
    }
    
    static func == (lhs: ReceiptModel, rhs: ReceiptModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
