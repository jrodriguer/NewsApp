//
//  ArticleWidgetModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 16/11/24.
//

import Foundation

struct ArticleWidgetModel: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let url: URL
    let imageData: Data?
    
    init(
        id: UUID,
        title: String,
        description: String,
        url: URL,
        imageData: Data? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
        self.imageData = imageData
    }
}
