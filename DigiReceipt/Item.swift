//
//  Item.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
