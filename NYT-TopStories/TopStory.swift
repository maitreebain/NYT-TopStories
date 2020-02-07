//
//  TopStory.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import ImageKit

struct TopStories: Codable & Equatable {
    let section: String
    let lastUpdated: String
    let results: [Article]
    private enum CodingKeys: String, CodingKey {
        case section
        case lastUpdated = "last_updated"
        case results
    }
}

struct Article: Codable & Equatable {
    let section: String
    let title: String
    let abstract: String
    let publishedDate: String
    let multimedia: [Multimedia]
    private enum CodingKeys: String, CodingKey {
        case section
        case title
        case abstract
        case publishedDate = "published_date"
        case multimedia
    }
}

struct Multimedia: Codable & Equatable{
    let url: String
    let format: String //superJumbo, thumbLarge
    let height: Double
    let width: Double
    let caption: String
}

extension Article { //article.getArticleImageURL(.superJumbo)
    func getArticleImageUrl(for imageFormat: ImageFormat) -> String {
        let result = multimedia.filter { $0.format == imageFormat.rawValue }
        
        guard let multimediaImage = result.first else {
            //result is 0
            return ""
        }
        
        return multimediaImage.url
    }
}
