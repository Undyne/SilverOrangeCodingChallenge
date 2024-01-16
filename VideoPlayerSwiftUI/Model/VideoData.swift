//
//  VideoData.swift
//  VideoPlayerSwiftUI
//
//  Created by Greg Rodrigues on 2024-01-13.
//

import Foundation

enum VideoDataDecodeError: Error {
    case publishedAtError
}

struct Author: Codable {
    let id: UUID
    let name: String
}

struct VideoData: Codable {
    let id: UUID
    let title: String
    let hlsURL: String
    let fullURL: String
    let descriptionMarkdown: String
    let publishedAt: Date
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case id, title, hlsURL, fullURL, publishedAt, author
        case descriptionMarkdown = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.hlsURL = try container.decode(String.self, forKey: .hlsURL)
        self.fullURL = try container.decode(String.self, forKey: .fullURL)
        let publishedAtString = try container.decode(String.self, forKey: .publishedAt)
        if let publishedAt = publishedAtString.toDate() {
            self.publishedAt = publishedAt
        } else {
            throw VideoDataDecodeError.publishedAtError
        }
        
        self.author = try container.decode(Author.self, forKey: .author)
        self.descriptionMarkdown = try container.decode(String.self, forKey: .descriptionMarkdown)
    }
}
