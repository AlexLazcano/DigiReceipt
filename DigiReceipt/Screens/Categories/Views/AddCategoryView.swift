//
//  AddCategoryView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import SwiftUI


import KeychainSwift
struct AddCategoryView: View {
    var keychain: KeychainSwift
    
    @State private var categoryName: String = ""
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let keychain = KeychainSwift()
    
    keychain.set("userId", forKey: "e1c47b81-e3ad-408e-8571-f08ebb8931d4")
    return AddReceiptView(keychain: keychain)
}
