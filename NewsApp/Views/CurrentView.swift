//
//  CurrentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct CurrentView: View {
    @Environment(ModelData.self) var modelData
    @Binding var currentView: Tabs
    
    var body: some View {
        VStack {
            if self.currentView == .Headers {
                HeadersView(articles: [])
            } else {
                FavoritesView()
            }
        }
    }
}

#Preview {
    CurrentView(currentView: .constant(.Headers))
        .environment(ModelData())
}
