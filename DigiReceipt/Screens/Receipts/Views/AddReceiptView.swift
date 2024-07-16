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
    //    @State private var settingsDetent = PresentationDetent.medium
    
    
    var body: some View {
        
        let total = receiptVM.products.reduce(into: 0) { result, el in
            if let digit = Double(String(el.price)) {
                result += digit
            }
        }
        
        return VStack  {
            Text("Receipt")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 30)
            VStack(alignment: .leading) {
                Text("Vendor").bold()
                TextField(text: $receiptVM.vendor) {
                    Text("Vendor")
                }.font(.title3)
                
            }
            
            DatePicker(selection: $receiptVM.date) {
                Text("Date")
                    .bold()
            }
            
            AddProductListView(products: $receiptVM.products)
            Spacer()
            HStack {
                Text("Total:")
                    .font(.largeTitle)
                Spacer()
                Text("\(format_currency(amount: total))")
                    .font(.largeTitle)
                
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "arrowshape.backward")
                    .font(.largeTitle)
                    .padding(5)
                
                    .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                       
                    }
                Spacer()
                Button("Save Receipt") {
//                    let receipt = ReceiptModel(
//                        vendor: receiptVM.vendor,
//                        products: receiptVM.products,
//                        paymentMethod: receiptVM.paymentMethod,
//                        categoryId: receiptVM.categoryId
//                    )
//                    
//                    // Save the new receipt
//                    ReceiptViewModel.saveReceipt(receipt: receipt)
                    
                    
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
            AddProductView(isSheet: $isSheet, addToListFunc: receiptVM.addProduct)
                .presentationDetents([.medium])
            
        }
        
    }
    
}

#Preview {
    let keychain = KeychainSwift()
    
    keychain.set("userId", forKey: "e1c47b81-e3ad-408e-8571-f08ebb8931d4")
    return AddReceiptView(keychain: keychain)
}


struct AddProductListView: View {
    
    @Binding var products: [ProductModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Items")
                .bold()
            
            
            if products.isEmpty {
                ContentUnavailableView {
                    Image(systemName: "pencil.circle")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                } description: {
                    Text("No Items in Receipt")
                } actions: {
                    Text("Add item")
                }
                
            } else {
                ForEach(products, id: \.name) { product in
                    ProductListRow(name: product.name, price: product.price)
                        .swipeActions {
                            Button {
                                print("Hello")
                            } label: {
                                Label("Delete", systemImage: "trash.circle.fill")
                            }
                        }
                    
                }
                Spacer()
            }
        
        }
    }
}



struct AddProductView: View {
    
    @State var name = ""
    @State var priceStr = ""
    
    @Binding var isSheet: Bool
    var addToListFunc: (String, String) -> Void
    
    
    var body: some View {
        VStack {
            Section(header: Text("Enter Product Information")) {
                TextField("Product Name", text: $name)
                TextField("Price", text: $priceStr)
                    .keyboardType(.decimalPad) // Use numeric keyboard for price input
            }
            .padding()
            Button(action: {
                addToListFunc(name, priceStr)
                isSheet.toggle()
                
            }, label: {
                Image(systemName: "checkmark.square")
            })
            .applyGradientBackgroundStyle()
            
        }
        
    }
}





