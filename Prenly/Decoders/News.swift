//
//  Source.swift
//  Prenly
//
//  Created by Luka Ivkovic on 09/09/2021.
//

import Foundation

struct Source: Decodable {
    let id: String?
}

struct Results: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Post]
}

struct Post: Decodable, Identifiable {
    //those are always there
    var title, url, publishedAt : String
    //those can miss for some cases
    var author, urlToImage, content, description : String?
    
    var source: Source

    var id: String? {
        source.id
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.url = ""
        self.urlToImage = ""
        self.publishedAt = ""
        self.content = ""
        self.author = ""
        self.source = Source.init(id: "")
    }
}
