//
//  functions.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation


func format_currency(amount: Double) -> String{
    
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .currency
    guard let formattedAmount = formatter.string(from: NSNumber(value: amount)) else {
        return formatter.string(from: NSNumber(value: 0.0))!
    }
    
    return formattedAmount
}
