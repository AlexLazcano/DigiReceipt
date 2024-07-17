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
    
    keychain.set("userId", forKey: "1ca0e225-631e-444e-90ae-047dfcc92a97")
    return AddReceiptView(keychain: keychain)
}
