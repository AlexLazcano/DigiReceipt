//
//  UserModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-14.
//

import Foundation


struct UserModel {
    var id = UUID()
    var name: String
    var collections: [CollectionModel]
    
}
