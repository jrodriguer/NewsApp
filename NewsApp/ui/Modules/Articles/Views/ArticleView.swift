//
//  ArticleView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import SwiftUI

struct ArticleView: View {
    @StateObject var vm = ArticleViewModel()
    enum ViewOption: String, CaseIterable {
        case cardView = "Card View"
        case listView = "List View"
    }
    @State private var selectedViewOption = ViewOption.cardView

    var body: some View {
        VStack {
            pickerSection
            
            switch selectedViewOption {
            case .cardView: CardSectionView()
            case .listView: ListSectionView()
            }
        }
        .navigationTitle("Headers")
    }
}

extension ArticleView {
    // TODO: Check default color on real terminal.
    
    private var pickerSection: some View {
        VStack {
            Picker("Select View", selection: $selectedViewOption) {
                ForEach(ViewOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}

#Preview {
    ArticleView()
}
