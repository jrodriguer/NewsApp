//
//  ContentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var bookmarkViewModel = BookmarkViewModel(saveKey: BookmarkKey.articleBookmarks)
    @State private var activeTab: TabBarType = .news
    @State private var isTabBarHidden: Bool = false
    
    let articleTabView: ArticleTabView<ArticleViewModel>
    let searchTabView: SearchTabView<ArticleViewModel>
        
    var body: some View {

        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18.0, *) {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .news) {
                            articleTabView
                                .toolbarVisibility(.hidden, for: .tabBar)
                                .environmentObject(bookmarkViewModel)
                        }
                        
                        Tab.init(value: .search) {
                            searchTabView
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        
                        Tab.init(value: .news) {
                            BookmarkTabView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                                .environmentObject(bookmarkViewModel)
                        }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        articleTabView
                            .tag(TabBarType.news)
                            .environmentObject(bookmarkViewModel)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        searchTabView
                            .tag(TabBarType.search)
                        
                        BookmarkTabView()
                            .tag(TabBarType.bookmarks)
                            .environmentObject(bookmarkViewModel)
                    }
                }
            }
            
            CustomTabBarView(activeTab: $activeTab)
        }
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
