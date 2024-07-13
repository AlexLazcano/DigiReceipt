//
//  ReceiptModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation

struct ProductRowModel {
    var name: String
    var price: Double
}

struct ReceiptModel {
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
    
    
    
}
