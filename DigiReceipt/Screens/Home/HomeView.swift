//
//  HomeView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import SwiftUI
import KeychainSwift

struct HomeView: View {
    
    
    var body: some View {
        let keychain = KeychainSwift()
        
        keychain.set("userId", forKey: "1ca0e225-631e-444e-90ae-047dfcc92a97")
        return NavigationStack {
            VStack {
                Spacer()
                VStack {
                    NavigationLink(destination: AddReceiptView(keychain: keychain)) {
                        Text("Add Receipt")
                            .applyGradientBackgroundStyle()
                            .padding()
                    }
                    Text("Fetch Receipts")
                        .applyGradientBackgroundStyle()
                        .padding()
                        .onTapGesture {
                            ReceiptViewModel.getReceiptsByUser { result in
                                switch result {
                                case .success(let receipts):
                                    // Handle successful retrieval of receipts
                                    print("Received receipts: \(receipts)")
                                    // Example: Update UI or perform further processing with `receipts` array
                                case .failure(let error):
                                    // Handle error
                                    print("Error fetching receipts: \(error)")
                                    // Example: Show an error message to the user or log the error
                                }
                            }
                        }
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
