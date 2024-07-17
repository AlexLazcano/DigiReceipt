//
//  UserViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-14.
//

import Foundation
import Observation
import KeychainSwift

@Observable class UserViewModel {
    var userDetails: UserModel?
    
    init(loadFakeUser: Bool = false) {
        
    }
    
    
    
    func loadUserDetails() -> String? {
        
        let keychain = KeychainSwift()
        
        guard let userId = keychain.get("userId") else {
            
            return nil
            
        }
        return userId
        
    }
    
    
    func create_user(username: String) {
        
        // Define the URL for your HTTP request
        let url = URL(string: "http://localhost:8080/api/users")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a JSON body for the request (if required)
        let requestBody: [String: Any] = [
            "username": username,
        ]
        
        // Convert the body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Error creating JSON data")
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
