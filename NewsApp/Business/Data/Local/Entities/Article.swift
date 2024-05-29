//
//  Article.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 29/5/24.
//

import Foundation

struct Article: Identifiable {
    let id: UUID
    
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: Date
    let content: String
    let source: ArticleSource
    
    static func build(apiObject: ArticleApiObject) -> Article? {
        guard let image = apiObject.urlToImage else { return nil }
        
        return Article(id: apiObject.id,
                       author: apiObject.author ?? "",
                       title: apiObject.title,
                       description: apiObject.description ?? "",
                       url: apiObject.url,
                       urlToImage: image,
                       publishedAt: apiObject.publishedAt,
                       content: apiObject.content ?? "",
                       source: apiObject.source
        )
    }
}

#if DEBUG
var MockArticle: Article {
    return Article(id: UUID(),
                   author: "Andy Kalmowitz",
                   title: "Naked Man Running Through Aisle Forces Plane To Land - Jalopnik",
                   description: "The Virgin Australia flight had to turn back to its original airport because of the unruly passenger.",
                   url: URL(string: "https://jalopnik.com/naked-man-running-through-aisle-forces-plane-to-land-1851503381")!,
                   urlToImage: URL(string: "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/c70ee309b56142b33858105fa544e03e.jpg")!,
                   publishedAt: Date(),
                   content: "A man on a Virgin Australia flight from Perth to Melbourne decided this venue was the perfect time to get naked and run down the aisle of the plane, knocking a crew member over in the process. This i… [+1172 chars]",
                   source: ArticleSource(name: "Jalopnik")
    )
}
#endif
