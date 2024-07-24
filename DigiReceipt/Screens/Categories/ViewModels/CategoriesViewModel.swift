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
            CategoryModel(name: "Food", categoryId: 1),
            CategoryModel(name: "Transportation", categoryId: 2),
            CategoryModel(name: "Entertainment", categoryId: 3),
            CategoryModel(name: "Groceries", categoryId: 4)
            
        ]
    }
    
}
