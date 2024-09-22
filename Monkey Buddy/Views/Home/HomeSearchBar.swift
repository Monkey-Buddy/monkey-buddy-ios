//
//  HomeSearchBar.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 9/20/24.
//

import SwiftUI

struct HomeSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search For a Gym", text: $searchText)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .padding(.horizontal)    }
}

#Preview {
    HomeSearchBar(searchText: .constant(""))
}
