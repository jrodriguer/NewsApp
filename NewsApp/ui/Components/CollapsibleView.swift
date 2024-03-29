//
//  CollapsibleView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 24/2/24.
//

import SwiftUI

struct CollapsibleView<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
        }
    }
}

#Preview {
    CollapsibleView(label: { Text("Title") }) {
        Text("Content goes here")
    }
}
