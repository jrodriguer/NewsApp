//
//  ContentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

enum TabSelect: String, CaseIterable {
    case news
    case search
    case bookmarks
    
    var tabIcon: String {
        switch self {
        case .news:
            return "network"
        case .search:
            return "magnifyingglass"
        case .bookmarks:
            return "bookmark"
        }
    }
    
    var title: String {
        switch self {
        case .news:
            return "News"
        case .search:
            return "Search"
        case .bookmarks:
            return "Bookmarks"
        }
    }
}

struct ContentView: View {
    
    @StateObject private var bookmarkViewModel = BookmarkViewModel(saveKey: BookmarkKey.articleBookmarks)
    @State private var activeTab: TabSelect = .news
    @State private var isTabBarHidden: Bool = false
//    @State private var tabLocation: CGRect = .zero
    
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
        
    var body: some View {
//        let status = activeTab == .news || activeTab == .search

//        ZStack(alignment: .bottom) {
//            Group {
        
                if #available(iOS 18.0, *) {
                    TabView(selection: $activeTab) {
                        //                        switch activeTab {
                        //                        case .news:
                        //                            articleTabView
                        //                                .environmentObject(bookmarkViewModel)
                        //                        case .search:
                        //                            searchTabView
                        //                        case .bookmarks:
                        //                            BookmarkTabView()
                        //                                .environmentObject(bookmarkViewModel)
                        //                        }
                        
                        Tab.init(value: .news) {
                            Text("News")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .search) {
                            Text("Search")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .news) {
                            Text("Bookmarks")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        Text("News")
                            .tag(TabSelect.news)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        Log.debug(tag: ContentView.self, message: "Hidden Tab Bar")
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("Search")
                            .tag(TabSelect.search)
                        
                        Text("Bookmarks")
                            .tag(TabSelect.bookmarks)
                    }
                    .overlay {
                        Button {
                            activeTab = activeTab == .news ? .search : .news
                        } label: {
                            Text("Switch Tabs")
                        }
                        .offset(y: 100)
                    }
                }
        
//            }
            
//            HStack(spacing: Spacing.medium) {
//                HStack(spacing: 0) {
//                    ForEach(TabSelect.allCases ,id: \.rawValue) { tab in
//                        TabButton(tabSelect: tab, activeTab: $activeTab, tabLocation: $tabLocation)
//                    }
//                }
//                .background(alignment: .leading) {
//                    Capsule()
//                        .fill(.white.gradient)
//                        .frame(width: tabLocation.width, height: tabLocation.height)
//                        .offset(x: tabLocation.minX)
//                }
//                .coordinateSpace(.named("TABBARVIEW"))
//                .padding(.horizontal, Spacing.minimum)
//                .frame(height: 45)
//                .background(
//                    .background
//                        .shadow(.drop(color: .primary.opacity(0.08), radius: 5, x: 5, y: 5))
//                        .shadow(.drop(color: .primary.opacity(0.08), radius: 5, x: -5, y: -5)),
//                    in: .capsule
//                )
//                .zIndex(10)
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: activeTab == .news ? "person.fill" : "slider.vertical.3")
//                        .frame(width: 42, height: 42)
//                        .foregroundStyle(Color.primary)
//                        .background(.accent.gradient)
//                        .clipShape(.circle)
//                        
//                }
//                .allowsHitTesting(status)
//                .offset(x: status ? 0 : -20)
//                .padding(.leading, status ? 0 : -42)
//            }
//            .animation(.smooth(duration: 0.3, extraBounce: 0), value: activeTab)
//        }
    }
}

struct HideTabBar: UIViewRepresentable {
    init(result: @escaping () -> Void) {
        UITabBar.appearance().isHidden = true
        self.result = result
    }
    
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let tabController = view.tabController {
                UITabBar.appearance().isHidden = false
                tabController.tabBar.isHidden = true
                result()
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {  }
}

extension UIView {
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: { $0 is UITabBarController}) as? UITabBarController {
            return controller
        }
        
        return nil
    }
}
