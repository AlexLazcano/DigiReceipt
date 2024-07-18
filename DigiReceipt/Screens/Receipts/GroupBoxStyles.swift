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
            Spacer()
            configuration.content
        }
        
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.15))
        )
        
    }
    
}

extension GroupBoxStyle where Self == ReceiptGroupBoxStyle {
    static var receiptGrid: ReceiptGridGroupBoxStyle { .init() }
}


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
