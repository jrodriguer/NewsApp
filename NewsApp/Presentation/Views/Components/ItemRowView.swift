//
//  ItemRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ItemRowView: View {
    var item: ArticleUIModel
    @EnvironmentObject var favorites: BookmarkViewModel
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            HStack {
                Text(item.displayTitle)
                    .applyStyle(.headLine)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .scaleEffect(isPressed ? 0.90 : 1.0, anchor: .center)
                
                Spacer()
                
                if favorites.contains(item) {
                    Image(systemName: "bookmark.fill")
                        .accessibilityLabel("This is a boorkmarked item")
                        .foregroundStyle(.accent)
                        
                }
            }
            .padding([.top, .horizontal], 12)
            .animation(.easeInOut, value: isPressed)
            
            .onLongPressGesture(minimumDuration: 1.5, pressing: { isPressing in
                withAnimation {
                    isPressed = isPressing
                }
            }, perform: {
                favorites.toggle(item)
            })
        }
        
    }
}
