//
//  ContentView.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case community
        case post
        case chat
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "star")
                }
                .tag(Tab.home)
        }
    }
}
#Preview {
    ContentView()
}
