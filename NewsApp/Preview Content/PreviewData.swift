//
//  PreviewData.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import SwiftUI

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

extension TopHeadlines {
    static var preview: TopHeadlines {
        let url = Bundle.main.url(forResource: "TopHeadlines", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let headlines = try! JSONDecoder.apiDecoder.decode(TopHeadlines.self, from: data)
        return headlines
    }
}
