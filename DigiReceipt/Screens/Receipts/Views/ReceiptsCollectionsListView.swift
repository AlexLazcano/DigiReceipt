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
        NavigationStack {
            
            ScrollView {
                LazyVStack {
                    ForEach($ReceiptsCollectionVM.receiptsCollections, id: \.self.collection_name) { $collection in
                        
                        Section(isExpanded: $collection.expanded) {
                            ReceiptsCollectionsView(collection: collection)
                            
                        } header: {
                            Text("\(collection.collection_name)")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                        }
                        .headerProminence(.increased)
                        .onTapGesture {
                            
                            withAnimation {
                                collection.expanded.toggle()
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 10)
            }
            
        }
    }
}

#Preview {
    ReceiptsCollectionsListView()
}


struct ReceiptsCollectionsView: View {
    
    var collection: ReceiptsCollectionModel
    @State var state = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(collection.receipts, id: \.self) { receipt in
                
                NavigationLink(value: receipt) {
                    ReceiptGridView(receipt: receipt)
                }
                
            }
            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.75)
                    .blur(radius: phase.isIdentity ? 0 : 10)
            }
        }
        .navigationDestination(for: ReceiptModel.self) { receipt in
            ReceiptDetailView(receipt: receipt)
        }
        .padding(.horizontal, 1)
        
    }
}


struct ReceiptGridView: View {
    var receipt: ReceiptModel

    var body: some View {
        GroupBox {
            Text("\(format_currency(amount: receipt.totalAmount))")
        } label: {
            Text("\(receipt.vendor)")

        }
        .groupBoxStyle(.receiptGrid)
        .foregroundColor(.primary)
        
        
    }
}


