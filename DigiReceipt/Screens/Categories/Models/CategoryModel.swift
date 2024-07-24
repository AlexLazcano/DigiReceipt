//
//  CollectionsModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import Foundation

struct CategoryModel: Identifiable, Codable {
    var categoryId: Int
    var name: String
    var categoryColor: CategoryColor
    var id: Int { categoryId }
   
    enum CategoryColor: String, Codable {
        case red
        case blue
        case green
        case yellow
        case orange
        case none
    }
    
    
    init(name: String, categoryId: Int) {
        self.name = name
        self.categoryColor = CategoryColor.none
        self.categoryId = categoryId
    }
}



