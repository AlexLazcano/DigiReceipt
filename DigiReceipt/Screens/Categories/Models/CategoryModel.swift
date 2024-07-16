//
//  CollectionsModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import Foundation

struct CategoryModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var averagePerMonth: Double
    var budgetPerMonth: Double?
    var budgetSpent: Double
    var budgetRemaining: Double
    
    
    init(name: String, averagePerMonth: Double, budgetPerMonth: Double, currentTotalMonth: Double) {
        self.name = name
        self.averagePerMonth = averagePerMonth
        self.budgetPerMonth = budgetPerMonth
        self.budgetSpent = currentTotalMonth
        self.budgetRemaining = budgetPerMonth - currentTotalMonth
    }
}



