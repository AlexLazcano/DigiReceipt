//
//  AddReceiptView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import SwiftUI
import KeychainSwift

struct AddReceiptView: View {
    var keychain: KeychainSwift
    @State var isSheet = false
    @State var receiptVM: AddReceiptViewModel = AddReceiptViewModel()
    @State var loading = false
    @State var completed = false
    //    @State private var settingsDetent = PresentationDetent.medium
    
    
    var body: some View {
        
        
        return VStack  {
            Text("Receipt")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Vendor").bold()
                    TextField(text: $receiptVM.vendor) {
                        Text("Vendor")
                    }.font(.title3)
                    
                }
                
                VStack(alignment: .trailing) {
                    Text("Payment method").bold()
                    Picker("Payment Method", selection: $receiptVM.paymentMethod) {
                                   Text("Credit Card").tag("Credit Card")
                                   Text("Debit Card").tag("Debit Card")
                                   Text("PayPal").tag("PayPal")
                                   Text("Apple Pay").tag("Apple Pay")
                               }
                               .pickerStyle(MenuPickerStyle()) // Use
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 20))
            
            
            DatePicker(selection: $receiptVM.date) {
                Text("Date")
                    .bold()
            }
            
            Spacer()
            HStack {
                Text("Total:")
                    .font(.largeTitle)
                Spacer()
                    
                
                TextField("Amount", value: $receiptVM.totalAmount, format: .number)
                               .padding()
                               .font(.largeTitle)
                
                
                
            }
            
            Spacer()
            
            HStack {
                Button("Save Receipt") {
                    let receipt = ReceiptModel(
                        vendor: receiptVM.vendor,
                        paymentMethod: receiptVM.paymentMethod,
                        category: receiptVM.category,
                        totalAmount: receiptVM.totalAmount
                    )
                    
//                    // Save the new receipt
                    #warning("TODO: Do completion")
                    ReceiptViewModel.saveReceipt(newReceipt: receipt, completion: {_ in } )
                    
                    
                }
                    .applyGradientBackgroundStyle()
                
                Spacer()
                
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
                    .padding(5)
                    .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isSheet.toggle()
                    }
            }
            
        }
        .padding(30)
        .sheet(isPresented: $isSheet) {
            
        }
        
    }
    
}

#Preview {
    let keychain = KeychainSwift()
    
    keychain.set("userId", forKey: "1ca0e225-631e-444e-90ae-047dfcc92a97")
    return AddReceiptView(keychain: keychain)
}


struct AddProductListView: View {
    
//    @Binding var products: [ProductModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Items")
                .bold()
        
        }
    }
}








