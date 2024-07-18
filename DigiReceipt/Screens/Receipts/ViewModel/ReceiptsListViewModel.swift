//
//  ReceiptsListViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-17.
//

import Foundation
import Observation

@Observable class ReceiptsListViewModel {
    var receipts: [ReceiptModel] = []
    
    init(receipts: [ReceiptModel]) {
        self.receipts = receipts
    }
    init(loadFakeData: Bool = false) {
        if loadFakeData {
            self.loadFakeData()
        }
        
    }
    
    
    func getReceiptsByUser(completion: @escaping (Result<[ReceiptModel], Error>) -> Void) {
        
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
           
                let receipts = try receiptDecoder.decode([ReceiptModel].self, from: data)
//                print("Receipts: \(receipts)")
                
                self.receipts = receipts
                completion(.success(receipts))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
    }
    
    func loadFakeData() {
        
        let receipts = (1...10).map { index in
            let products = (1...10).map { index2 in
                ProductModel(name: "Item \(index2)", price: 1.0 * Double(index2 + index))
            }
            
            return ReceiptModel(vendor: "Vendor \(index)", products: products, paymentMethod: "Visa", categoryId: "Food")
        }
        
        self.receipts = receipts
    }
    
    
}
