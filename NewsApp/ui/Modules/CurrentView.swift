//
//  CurrentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/24.
//

import SwiftUI

struct CurrentView: View {
    @Binding var currentView: Tabs
    
    var body: some View {
        VStack {
            if self.currentView == .Headers {
                ArticleView()
            } else {
                //FavoritesView()
            }
        }
    }
}

#Preview {
    CurrentView(currentView: .constant(.Headers))
}
