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
        let baseURL = api
        let path = receiptsPath
        
        let receipt = newReceipt
        
        
        print(receipt)
        let uuid = UUID(uuidString: "1ca0e225-631e-444e-90ae-047dfcc92a97")!
        // Define the URL for your HTTP request
        
//        receipt.setUserId(userId: uuid)
        
        print("saving")
        
        // Define the URL for your HTTP request
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.badURL))
            print("Invalid URL")
            return
        }
        
        let queryItems = [
            
            URLQueryItem(name: "userId", value: uuid.uuidString)
        ]
        
        urlComponents.queryItems = queryItems
        urlComponents.path = path
        
        
        // Define the URL for your HTTP request
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.badURL))
            print("Invalid URL")
            return
        }
        
        print(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
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
    
    
    static func getReceiptsByUser(completion: @escaping (Result<[ReceiptModel], Error>) -> Void) {
        
        // Define the base URL and path for your HTTP request
        let baseURL = "http://localhost:8080"
        let path = "/api/receipts"
        
        let uuid = UUID(uuidString: "1ca0e225-631e-444e-90ae-047dfcc92a97")!
        
        // Define the URL for your HTTP request
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.badURL))
            print("Invalid URL")
            return
        }
        
        let queryItems = [
            
            URLQueryItem(name: "userId", value: uuid.uuidString)
        ]
        
        urlComponents.queryItems = queryItems
        urlComponents.path = path
        
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.badURL))
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
                return
            }
            
            // Ensure there is data returned
            guard let data = data else {
                completion(.failure(NetworkError.nodata))
                print("No data received")
                return
            }
            
            // Handle the data (e.g., parsing JSON, etc.)
            do {
                // Example: decoding JSON response into a ReceiptModel array
                let decoder = JSONDecoder()
                let receipts = try decoder.decode([ReceiptModel].self, from: data)
                print("Receipts: \(receipts)")
                
                completion(.success(receipts))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
    }
}
