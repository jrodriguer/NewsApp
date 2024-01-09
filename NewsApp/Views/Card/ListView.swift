//
//  ListView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/24.
//

import SwiftUI

struct ListView: View {
    var title: String
    var author: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    ListView(title: "Israel-Gaza war live updates: Blinken in Middle East as U.S. seeks to avert war between Israel and Hezbollah - The Washington Post", author: "The Washington Post")
}
    
