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
        VStack {
            HStack(alignment: .top, spacing: Spacing.medium) {
                configuration.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45.0, height: 45.0)
                    .foregroundStyle(.primary)
                
                VStack(alignment: .leading, spacing: Spacing.minimum) {
                    configuration.title?
                        .applyStyle(.headLine)
                    configuration.message?
                        .applyStyle(.subHead)
                }
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark").scaledToFit()
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(Spacing.medium)
    }
}
