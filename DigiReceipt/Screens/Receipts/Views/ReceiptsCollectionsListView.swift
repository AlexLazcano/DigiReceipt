//
//  ReceiptsCollectionsListView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import SwiftUI

struct ReceiptsCollectionsListView: View {
    
    @State private var ReceiptsCollectionVM = ReceiptsCollectionViewModel(loadFakeData: true)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach($ReceiptsCollectionVM.receiptsCollections, id: \.self.collection_name) { $collection in
                        ReceiptsCollectionsView(collection: collection)
                            .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                    }
                }
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    ReceiptsCollectionsListView()
}


struct ReceiptsCollectionsView: View {
    
    var collection: CollectionModel
    @State var indexSelected: Int? = nil
    @Namespace private var receiptAnim
    
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    
    var body: some View {
        
        if let indexSelected = indexSelected {
            ReceiptDetailView(receipt: collection.receipts[indexSelected], namespace: receiptAnim, onClose: onClose)
            
        } else {
            CollectionListView
                .padding(.horizontal, 10)
        }
    }
    
    var CollectionListView: some View {
        VStack {
            Text("\(collection.collection_name)")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(collection.receipts.indices, id: \.self) { index in
                    receiptGridView(receipt: collection.receipts[index])
                        .onTapGesture {
                            indexSelected = index
                        }
                }
                
                .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1 : 0)
                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                        .blur(radius: phase.isIdentity ? 0 : 10)
                }
            }
            
            .padding(.horizontal, 1)
            Spacer()
        }
        .padding(.top, 50)
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
    
    func onClose() -> Void {
        indexSelected = nil
    }
    
    func receiptGridView(receipt: ReceiptModel) -> some View {
        GroupBox {
            Text("\(format_currency(amount: receipt.totalAmount))")
        } label: {
            Text("\(receipt.vendor)")
        }
        .matchedGeometryEffect(id: receipt, in: receiptAnim)
        .groupBoxStyle(.receiptGrid)
        .foregroundColor(.primary)
        
    }
    
    
}


