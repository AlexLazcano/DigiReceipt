//
//  ContentView.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-11.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            ReceiptsCollectionsListView()
                .tabItem {
                    Image(systemName: "book.pages")
                }
        }
        
    }
    
    
}

#Preview {
    ContentView()
}
