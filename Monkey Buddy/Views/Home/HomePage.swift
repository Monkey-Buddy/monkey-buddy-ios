//
//  HomePage.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 9/20/24.
//

import SwiftUI

struct HomePage: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            VStack {
                HomeHeader()
                Divider()
                HomeSearchBar(searchText: $searchText)
                Spacer()
            }
        }
    }
    }

#Preview {
    HomePage()
}
