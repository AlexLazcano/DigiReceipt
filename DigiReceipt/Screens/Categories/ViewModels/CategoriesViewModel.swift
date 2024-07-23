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
            CategoryModel(name: "Food", averagePerMonth: 100.0, budgetPerMonth: 100, currentTotalMonth: 25.0),
            CategoryModel(name: "Transportation", averagePerMonth: 50.0, budgetPerMonth: 100.0, currentTotalMonth: 50.0),
            CategoryModel(name: "Entertainment", averagePerMonth: 100.0, budgetPerMonth: 100.0, currentTotalMonth: 90.0),
            CategoryModel(name: "Groceries", averagePerMonth: 300.0, budgetPerMonth: 350.0, currentTotalMonth: 280.0)
            
        ]
    }
    
}
