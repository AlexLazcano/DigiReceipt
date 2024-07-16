//
//  CategoriesView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-15.
//

import SwiftUI
import Charts

struct CategoriesView: View {
    @State var categoriesVM = CategoriesViewModel()
    @State var userVM = UserViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    var body: some View {
        VStack {
            
            Text("Collections")
                .font(.title)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            LazyVGrid(columns: columns) {
                ForEach(categoriesVM.categories) {category in
                    CategoryView(category: category)
                        .background(.gray.gradient.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
                }
                
            }
            Spacer()
            Text("All Receipts")
                .padding()
                .background(.blue.gradient, in: RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(.background)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            
            Text("Add User")
                .padding()
                .background(.blue.gradient, in: RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(.background)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .onTapGesture {
                    print("Tapped")
                    userVM.create_user(username: "Jaram")
                }
            
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    CategoriesView()
}


struct Stream: Identifiable {
    var name: String
    var value: Double
    let id = UUID()
    var color: Color
}

struct CategoryView: View {
    var category: CategoryModel
    //    @State isPercent: Bool = false
    
    @State var isTapped = false
    
    
    
    var body: some View {
        
        let spentValue = isTapped ?  category.budgetSpent / category.budgetPerMonth : category.budgetSpent
        let remValue = isTapped ? category.budgetRemaining / category.budgetPerMonth : category.budgetRemaining
        
        let percentValue = category.budgetRemaining / category.budgetPerMonth
//        let percent = format_percent(amount: percentValue)
        return VStack(alignment: .leading) {
            Text("\(category.name)")
                .font(.title2)
            
            Text("This Month: ")
                .font(.footnote )
            Text("Avg: \(format_currency(amount: category.averagePerMonth))")
                .font(.subheadline)
            Text("Budget: \(format_currency(amount: category.budgetPerMonth))")
                .font(.headline)
            //            ZStack  {
            //                Chart {
            //                    ForEach(streams) {stream in
            //                        SectorMark(angle: .value("Stream", stream.value), innerRadius: .ratio(0.618), angularInset: 1)
            //                            .foregroundStyle(stream.color)
            //                            .cornerRadius(3)
            //                            .annotation(position: .overlay ) {
            //                                Text("\(isTapped ?  format_percent(amount: stream.value): format_currency(amount: stream.value)) ")
            //                                    .font(.footnote)
            //                                    .padding(1)
            //
            //                                    .foregroundStyle(.black)
            //                                    .bold()
            //                                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 5))
            //                            }
            //
            //                    }
            //
            //
            //                }
            //
            //                Text("\(percent)")
            //
            //            }
            
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.green.gradient)
                        .frame(width: geo.size.width * percentValue , height: 10) // Adjusted width
                    Rectangle()
                        .fill(Color.red.gradient)
                        .frame(width: geo.size.width * (1 - percentValue) , height: 10) // Adjusted width
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            HStack {
                Text("Remaining")
                Spacer()
                Text("Spent")
                    
            }
            .font(.caption2)
            
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .onTapGesture {
            isTapped.toggle()
        }
    }
}
