//
//  AddReceiptViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-16.
//

import Foundation
import Observation


@Observable class AddReceiptViewModel {
    var vendor: String
    var date: Date = .now
    var products: [ProductModel]
    var totalAmount: Double
    var paymentMethod: String
    var categoryId: String? = nil
    
    init() {
        self.vendor = ""
        self.date = Date()
        self.products = []
        self.totalAmount = 0.0
        self.paymentMethod = "paymentMethod"
        
    }
    
    init(vendor: String, date: Date, products: [ProductModel], totalAmount: Double, paymentMethod: String, categoryId: String? = nil) {
        self.vendor = vendor
        self.date = date
        self.products = products
        self.totalAmount = totalAmount
        self.paymentMethod = paymentMethod
        self.categoryId = categoryId
    }
    
    
    
    func addProduct(product: ProductModel) {
        self.products.append(product)
    }
    
    func addProduct(name: String, priceStr: String) {
        guard let price = Double(priceStr) else {
                // Handle invalid price input if needed
                print("Invalid price format: \(priceStr)")
                return
            }
        self.products.append(ProductModel(name: name, price: price))
    }
    
    func remove(product: ProductModel, index: Int) {
        self.products.remove(at: index)
    }
}
