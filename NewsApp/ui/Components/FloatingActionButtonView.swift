//
//  FloatingActionButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButtonView: View {
    var name: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: name)
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
            }
            .background(Color(.baseGray))
            .foregroundStyle(Color.red)
        }
        .background(Color.gray.brightness(0.4))
        .cornerRadius(30)
    }
}

#Preview {
    FloatingActionButtonView(name: "chevron.baseGray", action: {})
}
