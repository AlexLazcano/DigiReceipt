//
//  ReceiptModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation

//struct ProductModel: Codable {
//    var productId = UUID()
//    var name: String
//    var price: Double
//    var receiptId: UUID?
//    
//    var id: UUID { productId }
//    
//}

struct ReceiptModel: Identifiable, Hashable, Codable {
    var receiptId = UUID()
    var vendor: String
    var date: Date = .now
//    var products: [ProductModel]
    var totalAmount: Double = 0.0
    var paymentMethod: String
    var categoryId: String? = nil
    var userId: UUID? = nil
    
    var id: UUID { receiptId }
    // Use CodingKeys to match the JSON keys
    private enum CodingKeys: String, CodingKey {
        case receiptId
        case vendor
        case date
        case paymentMethod
//        case products
        case categoryId
        case userId
        case totalAmount
    }
    
    static func decoder() -> JSONDecoder {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
    
    // Decodable conformance
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            receiptId = try container.decode(UUID.self, forKey: .receiptId)
            vendor = try container.decode(String.self, forKey: .vendor)
            
            // Use custom date decoding
            let dateString = try container.decode(String.self, forKey: .date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let parsedDate = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
            date = parsedDate
            
//            products = try container.decode([ProductModel].self, forKey: .products)
            paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
            categoryId = try container.decodeIfPresent(String.self, forKey: .categoryId)
            userId = try container.decodeIfPresent(UUID.self, forKey: .userId)
//            totalAmount = products.reduce(0) { $0 + $1.price }
            totalAmount = try container.decode(Double.self, forKey: .totalAmount)
            
        }

    
    
    
    init(vendor: String, paymentMethod: String,  categoryId: String? = nil, totalAmount: Double){
        
        self.vendor = vendor
        self.paymentMethod = paymentMethod
        self.categoryId = categoryId
        self.totalAmount = totalAmount
    }
    
    static func == (lhs: ReceiptModel, rhs: ReceiptModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    mutating func setUserId(userId: UUID) {
        self.userId = userId
    }
    
    
    
    
}
