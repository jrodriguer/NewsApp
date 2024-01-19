//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    var articles: [Article]
    
    enum ViewOption: String, CaseIterable {
        case cardView = "Card View"
        case listView = "List View"
    }
    @State private var selectedViewOption = ViewOption.cardView
    @EnvironmentObject var favorites: Favorites
    @Namespace var topID
    @Namespace var bottomID
    @State private var additionalAnimationColor = Color.blue
        
    var body: some View {
        VStack {
            viewForSelectedOption()
        }
    }
    
    private func filterToogle() -> some View {
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
    
    @ViewBuilder
    private func viewForSelectedOption() -> some View {
        switch selectedViewOption {
        case .cardView:
            cardView()
        case .listView:
            listView()
        }
    }
        
    private func cardView() -> some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    ZStack {
                        VStack {
                            filterToogle()
                            
                            if !articles.isEmpty {
                                ForEach(articles) { article in
                                    if article.title != "[Removed]" {
                                        NavigationLink {
                                            ArticleDetail(article: article)
                                        } label: {
                                            ArticleCard(article: article)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                }
                                
                            } else {
                                Text("No articles available")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        
                        // TODO: Add button for go to top
                        
                        VStack {
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        proxy.scrollTo(topID)
                                    }
                                }, label: {
                                    Text("")
                                        .font(.system(.largeTitle))
                                        .frame(width: 77, height: 70)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 7)
                                })
                                .id(bottomID)
                                .background(Color.blue)
                                .cornerRadius(38.5)
                                .padding()
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                            }
                        }
                    }
                }
                .navigationTitle("Headers")
            }
        }
    }
    
    private func listView() -> some View {
        NavigationView {
            VStack {
                filterToogle()
                
                List {
                    if !articles.isEmpty {
                        ForEach(articles) { article in
                            if article.title != "[Removed]" {
                                NavigationLink {
                                    ArticleDetail(article: article)
                                    
                                } label: {
                                    ArticleRow(article: article)
                                }
                            }
                        }
                    } else {
                        Text("No articles available")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationTitle("Headers")
        }
    }
}

#Preview {
    HeadersView(articles: ModelData().news.articles)
        .environmentObject(Favorites())
}
