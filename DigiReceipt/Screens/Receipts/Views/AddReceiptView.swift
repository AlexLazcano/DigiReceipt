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
        
        let total = receiptVM.products.reduce(into: 0) { result, el in
            if let digit = Double(String(el.price)) {
                result += digit
            }
        }
        
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
                Button("Save Receipt") {
                    let receipt = ReceiptModel(
                        vendor: receiptVM.vendor,
                        products: receiptVM.products,
                        paymentMethod: receiptVM.paymentMethod,
                        categoryId: receiptVM.categoryId
                    )
                    print(receipt.products)
                    
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
            AddProductView(isSheet: $isSheet, addToListFunc: receiptVM.addProduct)
                .presentationDetents([.medium])
            
        }
        
    }
    
}

#Preview {
    let keychain = KeychainSwift()
    
    keychain.set("userId", forKey: "1ca0e225-631e-444e-90ae-047dfcc92a97")
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
                List {
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
                }
                .listStyle(.plain)
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





