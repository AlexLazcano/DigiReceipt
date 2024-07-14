//
//  ReceiptsCollectionsListView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import SwiftUI

struct ReceiptsCollectionsListView: View {
    
    var ReceiptsCollectionVM = ReceiptsCollectionViewModel(loadFakeData: true)
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(ReceiptsCollectionVM.receiptsCollections, id: \.self.collection_name) { collection in
                        ReceiptsCollectionsView(collection: collection)
                        
                    }
                }
            }
            .padding(.horizontal, 10)
            
        }
    }
}

#Preview {
    ReceiptsCollectionsListView()
}


struct ReceiptsCollectionsView: View {
    
    var collection: ReceiptsCollectionModel
    
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    
    var body: some View {
        
        VStack {
            Text("\(collection.collection_name)")
                .font(.title)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(collection.receipts, id: \.self) { receipt in
                    NavigationLink(value: receipt) {
                        ReceiptGridView(receipt: receipt)
                    }
                }
            }
            .navigationDestination(for: ReceiptModel.self) { receipt in
                ReceiptDetailView(receipt: receipt)
            }
        }
        
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
    }
}


