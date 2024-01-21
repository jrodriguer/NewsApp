//
//  CurrentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct CurrentView: View {
    @Binding var currentView: Tabs
    @StateObject var favorites = Favorites()
    
    var body: some View {
        NavigationView {
            VStack {
                if self.currentView == .Headers {
                    HeadersView(articles: ModelData().news.articles)
                } else {
                    FavoritesView()
                }
            }
        }
        .environmentObject(favorites)
    }
}

#Preview {
    CurrentView(currentView: .constant(.Headers))
}
