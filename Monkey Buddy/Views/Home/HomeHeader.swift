//
//  HomeHeader.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 9/20/24.
//

import SwiftUI

struct HomeHeader: View {
    var body: some View {
        HStack {
           Text("Hello User!")
               .font(.title2)
               .fontWeight(.bold)
           Spacer()
           Text("Let's find a Buddy")
               .font(.subheadline)
           Spacer()
           Image(systemName: "waveform.path")
           Image(systemName: "bell")
       }
       .padding(.horizontal)
    }
}

#Preview {
    HomeHeader()
}
