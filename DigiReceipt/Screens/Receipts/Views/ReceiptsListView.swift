//
//  RecentReceiptsView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-17.
//

import SwiftUI

struct ReceiptsListView: View {
    
    @State var indexSelected: Int? = nil
    @State private var receiptsVM = ReceiptListViewModel()
    @Namespace private var receiptAnim

    var collection_name: String = "Recent"
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        
        VStack {
            
            if let indexSelected = indexSelected {
                ReceiptDetailView(receipt: receiptsVM.receipts[indexSelected], namespace: receiptAnim, onClose: onClose)
                
            } else {
                ListView
                    .padding(.horizontal, 10)
            }
            
        }
    }
    
    var ListView: some View {
        VStack {
            
            Text("\(collection_name)")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(receiptsVM.receipts.indices, id: \.self) { index in
                        receiptGridView(receipt: receiptsVM.receipts[index])
                            .onTapGesture {
                                withAnimation {
                                    indexSelected = index
                                }
                               
                            }
                    }
                    .scrollTransition(.animated.threshold(.visible(1))) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0)
                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                            .blur(radius: phase.isIdentity ? 0 : 10)
                    }
                    
                }
                .padding(1)
                
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            
            Spacer()
            
        }
        .padding(.top, 50)
        .padding(.horizontal, 20)
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .onAppear() {
            receiptsVM.getReceiptsByUser { result in
                switch result {
                case .success(let receipts):
                    // Handle successful retrieval of receipts
                    
                    DispatchQueue.main.async {
                        // Example: assuming you have a @State property to hold receipts
                    }
                case .failure(let error):
                    // Handle error case
                    print("Error fetching receipts: \(error.localizedDescription)")
                    // Optionally, show an error message or take appropriate action
                }
            }
            
        }
    }
    
    
    func onClose() -> Void {
        withAnimation {
            indexSelected = nil
        }
        
    }
    
    func receiptGridView(receipt: ReceiptModel) -> some View {
        GroupBox {
            Text("\(format_currency(amount: receipt.totalAmount))")
                .matchedGeometryEffect(id: "\(receipt)-TotalAmount", in: receiptAnim)
        } label: {
            Text("\(receipt.vendor)")
                .matchedGeometryEffect(id: "\(receipt)-Vendor", in: receiptAnim)
            
        }
        .matchedGeometryEffect(id: "\(receipt)", in: receiptAnim)
        .groupBoxStyle(.receiptGrid)
        .foregroundColor(.primary)
        
    }
}



#Preview {
    ReceiptsListView()
}
