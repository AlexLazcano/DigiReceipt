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
    var totalAmount: Double
    var paymentMethod: String
    var category: CategoryModel? = nil
    
    init() {
        self.vendor = ""
        self.date = Date()
        self.totalAmount = 0.0
        self.paymentMethod = "paymentMethod"
        
    }
    
    init(vendor: String, date: Date, totalAmount: Double, paymentMethod: String, categoryId: String? = nil) {
        self.vendor = vendor
        self.date = date
        self.totalAmount = totalAmount
        self.paymentMethod = paymentMethod
        self.category = category
    }
    
    
    
}
