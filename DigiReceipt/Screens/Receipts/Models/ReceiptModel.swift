//
//  ReceiptModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation

struct ProductModel: Codable {
    var productId = UUID()
    var name: String
    var price: Double
    var id: UUID { productId }
    var receiptId: UUID?
    
}

struct ReceiptModel: Identifiable, Hashable, Codable {
    var receiptId = UUID()
    var vendor: String
    var date: Date = .now
    var products: [ProductModel]
    var totalAmount: Double
    var paymentMethod: String
    var categoryId: String?
    var userId: UUID?
    
    var id: UUID { receiptId }
    
    
    init(vendor: String, products: [ProductModel], paymentMethod: String,  categoryId: String? = nil){
        
        let total = products.reduce(0) { sum, product in
            sum + product.price
        }
        self.products = products
        self.vendor = vendor
        self.totalAmount = total
        self.paymentMethod = paymentMethod
        self.categoryId = categoryId
    }
    
    static func == (lhs: ReceiptModel, rhs: ReceiptModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    mutating func setUserId(userId: UUID) {
        self.userId = userId
    }
    

    
    
}
