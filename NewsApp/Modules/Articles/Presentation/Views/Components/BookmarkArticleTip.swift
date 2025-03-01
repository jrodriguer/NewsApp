//
//  BookmarkArticleTip.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 20/2/25.
//

import SwiftUI
import TipKit

struct BookmarkArticleTip: Tip {
    var title: Text {
        Text("Save as a Bookmark")
            .foregroundStyle(.primary)
    }

    var message: Text? {
        Text("Add articles to your bookmark list for easy access later.")
            .foregroundStyle(.primary)
    }
    
    
    var image: Image? {
        Image(systemName: "bookmark")
    }
}

struct CustomTipViewStyle: TipViewStyle {
    func makeBody(configuration: TipViewStyle.Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                configuration.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.primary)
                    .padding(.top, 8)
                
                VStack(alignment: .leading, spacing: 2) {
                    configuration.title?
                        .applyStyle(.headLine)
                    configuration.message?
                        .applyStyle(.subHead)
                    
                    ForEach(configuration.actions) { action in
                        Button(action: action.handler) {
                            action
                                .label()
                                .foregroundStyle(.primary)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark")
                        .scaledToFit()
                        .foregroundStyle(Color.secondary)
                        .padding(4)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(10)
    }
}
