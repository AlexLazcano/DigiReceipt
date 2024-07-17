//
//  Network.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-17.
//

import Foundation


enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case nodata
}


let DATE_FORMAT = "yyyy-MM-dd HH:mm:ss Z"
let api = "http://localhost:8080"
let receiptsPath = "/api/receipts"
