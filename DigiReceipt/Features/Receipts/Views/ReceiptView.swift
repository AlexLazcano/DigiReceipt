//
//  ReceiptView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import SwiftUI
import Combine

struct ReceiptView: View {
    @ObservedObject var viewModel: ReceiptViewModel
    
    var body: some View {
        
        VStack {
            Text(viewModel.receipt.vendor)
                .font(.largeTitle)
                .padding(.top, 20)
                .bold()
            
            
            List {
                ForEach(viewModel.receipt.products, id: \.name) { product in
                    ProductListRow(name: product.name, price: product.price)
                        .swipeActions {
                            Button {
                                print("Hello")
                            } label: {
                                Label("Delete", systemImage: "trash.circle.fill")
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .listStyle(.plain)
            .frame(height: 400)
            
            HStack {
                Text("Total: ")
                    .font(.title)
                    .bold()
                Spacer()
                Text("\(format_currency(amount: viewModel.receipt.totalAmount))")
                    .font(.title)
                    .bold()
            }
            
            Text("\(viewModel.receipt.paymentMethod)")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .padding(.horizontal, 25)
        
    }
}

#Preview {
    
    let exampleReceipt = ReceiptModel(vendor: "Ikea", products: [
        ProductRowModel(name: "Chair", price: 400),
        ProductRowModel(name: "Bed", price: 200)
    ], paymentMethod: "Visa")
    return ReceiptView(viewModel: ReceiptViewModel(receipt: exampleReceipt))
    
}

struct ProductListRow: View {
    let name: String
    let price: Double
    var body: some View {
        HStack {
            Text("\(name)")
                .font(.title2)
            Spacer()
            Text("\(format_currency(amount: price))")
                .font(.title3)
        }
        .frame(height: 50)
        
    }
}
