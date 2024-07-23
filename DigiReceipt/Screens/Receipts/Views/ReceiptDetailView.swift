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
                        .matchedGeometryEffect(id: "\(receipt)-TotalAmount", in: namespace)
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
                            
                            withAnimation {
                                if(abs(offset.width) > 100) {
                                    onClose()
                                    offset = .zero
                                } else {
                                    offset = .zero
                                }
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
                    .matchedGeometryEffect(id: "\(receipt)-Vendor", in: namespace)
                
            }
            .matchedGeometryEffect(id: "\(receipt)-Container", in: namespace)
            .groupBoxStyle(.receipt)
            
        }
        
    }
    
}

#Preview {
    @Namespace var ns
    let userID = UUID()
    let exampleReceipt = ReceiptModel(vendor: "Ikea", paymentMethod: "Visa", categoryId: "Home 🏡", totalAmount: 0)
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
