//
//  ReceiptViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation
import Observation


@Observable class ReceiptViewModel {
    
    var receipt: ReceiptModel
    
    init(receipt: ReceiptModel){
        self.receipt = receipt
    }
    
    static func saveReceipt(newReceipt: ReceiptModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        var receipt = newReceipt
        
        
        print(receipt)
        let uuid = UUID(uuidString: "e1c47b81-e3ad-408e-8571-f08ebb8931d4")!
        // Define the URL for your HTTP request
        
        receipt.setUserId(userId: uuid)
        
        print("saving")
        
        
        // Define the URL for your HTTP request
        guard let url = URL(string: "http://localhost:8080/api/receipts") else {
            print("Invalid URL")
            return
        }
        
        print(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        do {
            let jsonData = try encoder.encode(receipt)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON: \(jsonString)")
            } else {
                print("Error converting JSON data to string")
            }
        } catch {
            print("Error encoding receipt to JSON: \(error.localizedDescription)")
        }
        
        // Encode the receipt to JSON
        guard let jsonData = try? encoder.encode(receipt) else {
            print("Error encoding receipt to JSON")
            return
        }
        
        // Assign the JSON data to the request's HTTP body
        request.httpBody = jsonData
        
        // Create a URLSession task for making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response from server
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Response status code: \(httpResponse.statusCode)")
            if httpResponse.statusCode == 201 {
                                completion(.success(()))
                            } else {
                                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
                            }
           
        }
        task.resume()
    }
    
    
    
}
