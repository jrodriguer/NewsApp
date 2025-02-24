//
//  TabButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 24/2/25.
//

import SwiftUI

struct TabButton: View {
    
    let tabSelect: TabSelect
    
    @Binding var selectedTab: TabSelect
    /// For matched geometry effect
    @Namespace private var animation
    /// View properties
    @Binding var tabLocation: CGRect
    
    var body: some View {
        Button {
            selectedTab = tabSelect
        } label: {
            HStack(spacing: Spacing.minimum) {
                Image(systemName: tabSelect.tabIcon)
                    .renderingMode(.template)
                /// This compares the selection to the button's associated enum.
                /// The enum provides the image name to the button,
                /// but we are always dealing with a case of the enum.
                    .opacity(selectedTab == tabSelect ? (1) : (0.5))
                    .frame(width: 32, height: 32)
                    .lineLimit(1)
                
                if selectedTab == tabSelect {
                    Text(tabSelect.title)
                        .applyStyle(.headLine)
                }
            }
            .foregroundStyle(selectedTab == tabSelect ? Color.primary : .secondary.opacity(0.6))
            .padding(.vertical, Spacing.minimum)
            .padding(.leading, Spacing.small)
            .padding(.trailing, Spacing.medium)
            .contentShape(.rect)
            .background {
                if selectedTab == tabSelect {
                    Capsule()
                        .fill(Color.accent.gradient)
                    /// slight fade in/out effect while swiutching from one tab to another
                    /// Let's remove that effect sugin the new onGeometryChange modfier
                        .onGeometryChange(for: CGRect.self, of: {
                            $0.frame(in: .named("TABBARVIEW"))
                        }, action: { newValue in
                            tabLocation = newValue
                        })
                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
