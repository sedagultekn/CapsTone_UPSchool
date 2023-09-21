//
//  File.swift
//  newsApp
//
//  Created by Seda Gültekin on 16.09.2023.
//

import Foundation
// MARK: - Source
struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    //let source: Source?
    let author: String?
    let title: String?
    let description: String?
   let url:String?
    let urlToImage: String?
    //let publishedAt: String?
   let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}

    

