//
//  ReceiptViewModel.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import Foundation



class ReceiptViewModel: ObservableObject {
    
    @Published var receipt: ReceiptModel
    
    init(receipt: ReceiptModel){
        self.receipt = receipt
    }

    
    
    
    
    

    
    
}
