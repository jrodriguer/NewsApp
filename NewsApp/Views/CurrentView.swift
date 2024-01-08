//
//  CurrentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct CurrentView: View {
    @Binding var currentView: Tabs
    
    var body: some View {
        VStack {
            if self.currentView == .Headers {
                HeadersView()
            } else {
                FavoritesView()
            }
        }
    }
}

#Preview {
    CurrentView(currentView: .constant(.Headers))
}
