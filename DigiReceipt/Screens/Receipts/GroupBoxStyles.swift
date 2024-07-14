//
//  ReceiptStyle.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-12.
//

import Foundation
import SwiftUI

struct ReceiptGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        VStack(alignment: .center) {
            configuration.label
            configuration.content
        }
        .padding(30)
        .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 12))
        .padding(20)
        
    }
    
}

extension GroupBoxStyle where Self == ReceiptGroupBoxStyle {
    static var receipt: ReceiptGroupBoxStyle { .init() }
}

struct ReceiptGridGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        VStack(alignment: .leading) {
            configuration.label
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .font(.title2)
            
            configuration.content
                .font(.title3)
            
            Spacer()
        }
        
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThickMaterial)
                .stroke(Color.gray, lineWidth: 1)
        )
        
    }
    
}

extension GroupBoxStyle where Self == ReceiptGroupBoxStyle {
    static var receiptGrid: ReceiptGridGroupBoxStyle { .init() }
}
