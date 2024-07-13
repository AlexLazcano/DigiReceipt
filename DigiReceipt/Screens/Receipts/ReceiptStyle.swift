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
