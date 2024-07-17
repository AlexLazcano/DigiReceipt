//
//  ReceiptDetailView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import SwiftUI
import Combine

struct ReceiptDetailView: View {
    var receipt: ReceiptModel
    let namespace: Namespace.ID
    var onClose: () -> Void
    
    @State private var offset = CGSize.zero
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(.blue.gradient.opacity(0.9))
                .ignoresSafeArea()
            
            GroupBox {
                List {
                    ForEach(receipt.products, id: \.name) { product in
                        ProductListRow(name: product.name, price: product.price)
                            .swipeActions {
                                Button {
                                    print("Hello")
                                } label: {
                                    Label("Delete", systemImage: "trash.circle.fill")
                                }
                                
                            }
                        
                    }
                    
                    .listRowBackground(Rectangle()
                        .fill(.white.opacity(0))
                        .cornerRadius(12)
                    )
                    .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    
                    
                }
                .listRowSpacing(10)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .frame(height: 300)
                
                
                HStack {
                    Text("Total: ")
                        .font(.title)
                        .bold()
                    Spacer()
                    Text("\(format_currency(amount: receipt.totalAmount))")
                        .font(.title)
                        .bold()
                }
                
                Text("\(receipt.paymentMethod)")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Text("\(offset.width)")
                    .frame(maxWidth: .infinity)
                    .background(Rectangle())
                    .gesture(DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            if(abs(offset.width) > 100) {
                                onClose()
                                offset = .zero
                            } else {
                                offset = .zero
                            }
                            
                        }
                    )
                    
                    
                
                
                
            } label: {
                HStack(alignment: .center) {
                    Text(receipt.date, style: .date)
                        .bold()
                        .font(.callout)
                    Spacer()
                    if let category = receipt.categoryId {
                        
                        Text(category)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .font(.title3)
                            .background(.regularMaterial, in: Capsule())
                    }
                }
                
                
                Text(receipt.vendor)
                    .font(.largeTitle)
                    .bold()
                
            }
            .groupBoxStyle(.receipt)
            
        }
        
    }
        
}

#Preview {
    @Namespace var ns
    let userID = UUID()
    let exampleReceipt = ReceiptModel(vendor: "Ikea", products: [
        ProductModel(name: "Chair", price: 400),
        ProductModel(name: "Bed", price: 200)
    ], paymentMethod: "Visa", categoryId: "Home 🏡")
    return ReceiptDetailView(receipt: exampleReceipt, namespace: ns, onClose: {} )
    
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
        
    }
}
