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
    
    static func saveReceipt(receipt: ReceiptModel) {
        
        // Define the URL for your HTTP request
        guard let url = URL(string: "http://localhost:8080/api/receipts") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the receipt to JSON
        guard let jsonData = try? JSONEncoder().encode(receipt) else {
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
            
            // Handle response data if needed
            if let data = data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Response JSON: \(responseJSON)")
                    // Process response JSON here
                } else {
                    print("Invalid JSON response")
                }
            }
        }
        task.resume()
    }
    
    
    
}
