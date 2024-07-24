//
//  RecentReceiptsView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-17.
//

import SwiftUI

struct ReceiptsListView: View {
    
    @State var indexSelected: Int? = nil
    @State var receiptsVM: ReceiptsListViewModel
    @Namespace private var receiptAnim

    var collection_name: String = "Recent"
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 1)
    
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
            HStack {
                Text("\(receipt.vendor)")
                    .matchedGeometryEffect(id: "\(receipt)-Vendor", in: receiptAnim)
                    .font(.title2)
                    .bold()
                    
                Spacer()
                Text("\(format_currency(amount: receipt.totalAmount))")
                    .matchedGeometryEffect(id: "\(receipt)-TotalAmount", in: receiptAnim)
                    .font(.title3)
                    
            }
            
        } label: {
            HStack {
                Text("\(receipt.date.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
              
                
                if let category = receipt.category {
                    Text("\(category.name)")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundStyle(.thickMaterial)
                        .background(.red.gradient, in: RoundedRectangle(cornerRadius: 10))
                }
                    
            }
            .padding(.bottom, 5)
            
        }
        .matchedGeometryEffect(id: "\(receipt)-Container", in: receiptAnim)
        .groupBoxStyle(.receiptGrid)
        .foregroundColor(.primary)
        
    }
}



#Preview {
    
    var receiptsVM = ReceiptsListViewModel(loadFakeData: true)
    return ReceiptsListView(receiptsVM: receiptsVM)
}
