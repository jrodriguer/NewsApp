//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    var body: some View {
        VStack {
            Spacer()
            Grid {
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle("Headers")
    }
}

#Preview {
    HeadersView()
}
