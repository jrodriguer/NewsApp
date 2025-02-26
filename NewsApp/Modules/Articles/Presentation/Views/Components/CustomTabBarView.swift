//
//  CustomTabBarView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 24/2/25.
//

import SwiftUI

struct CustomTabBarView: View {
    
    var activeForeground: Color = .primary
    var activeBackground: Color = .accent
    @Binding var activeTab: TabBarType
    @Namespace private var animation
    @State private var tabLocation: CGRect = .zero
    
    var body: some View {
        let status = activeTab == .news || activeTab == .search

        HStack(spacing: !status ? 0 : 12) {
             HStack(spacing: 0) {
                ForEach(TabBarType.allCases ,id: \.rawValue) { tab in
                    Button {
                        activeTab = tab
                    } label: {
                        HStack(spacing: Spacing.minimum) {
                            Image(systemName: tab.tabIcon)
                                .renderingMode(.template)
                            /// This compares the selection to the button's associated enum.
                            /// The enum provides the image name to the button,
                            /// but we are always dealing with a case of the enum.
                                .opacity(activeTab == tab ? (1) : (0.5))
                                .frame(width: 32, height: 32)
                                .lineLimit(1)
                            
                            if activeTab == tab {
                                Text(tab.title)
                                    .applyStyle(.headLine)
                            }
                        }
                        .foregroundStyle(activeTab == tab ? activeForeground : .secondary)
                        .padding(.vertical, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 15)
                        .contentShape(.rect)
                        .background {
                            if activeTab == tab {
                                Capsule()
                                    .fill(activeBackground.gradient)
                                /// slight fade in/out effect while switching from one tab to another
                                /// Let's remove that effect using the new onGeometryChange modfier
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
            .background(alignment: .leading) {
                Capsule()
                    .fill(.white.gradient)
                    .frame(width: tabLocation.width, height: tabLocation.height)
                    .offset(x: tabLocation.minX)
            }
            .coordinateSpace(.named("TABBARVIEW"))
            .padding(.horizontal, Spacing.minimum)
            .frame(height: 45)
            .background(
                Capsule()
                    .foregroundStyle(Color.white)
                    .shadow(
                        color: Color.background.opacity(0.08),
                        radius: 5,
                        x: 5,
                        y: 5
                    )
                    .shadow(
                        color: Color.background.opacity(0.06),
                        radius: 5,
                        x: -5,
                        y: -5
                    )
            )
            .zIndex(10)
            
            Button {
                
            } label: {
                Image(systemName: activeTab == .news ? "person.fill" : "slider.vertical.3")
                    .frame(width: 42, height: 42)
                    .foregroundStyle(Color.primary)
                    .background(.accent.gradient)
                    .clipShape(.circle)
                
            }
            .allowsHitTesting(status)
            .offset(x: status ? 0 : -20)
            .padding(.leading, status ? 0 : -42)
        }
        .padding(.bottom, Spacing.minimum)
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: activeTab)
    }
}
