//
//  CategoriesViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import Foundation
import Observation

@Observable class CategoriesViewModel {
    
    var categories: [CategoryModel] = []
    
    
    init() {
        loadSampleCategories()
    }
    
    
    func loadSampleCategories() -> Void {
        self.categories =  [
            CategoryModel(name: "Food", averagePerMonth: 200.0, budgetPerMonth: 250.0, currentTotalMonth: 180.0),
            CategoryModel(name: "Transportation", averagePerMonth: 100.0, budgetPerMonth: 120.0, currentTotalMonth: 90.0),
            CategoryModel(name: "Entertainment", averagePerMonth: 150.0, budgetPerMonth: 200.0, currentTotalMonth: 170.0),
            CategoryModel(name: "Groceries", averagePerMonth: 300.0, budgetPerMonth: 350.0, currentTotalMonth: 280.0)
            
        ]
    }
    
}
