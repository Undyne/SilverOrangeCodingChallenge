//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Greg Rodrigues on 2024-01-15.
//

import Foundation

class VideoPlayerViewModel: ObservableObject {
    var videos: [VideoData] = []
    var index: Int? = nil
    var playing: Bool = false
    var showButtons: Bool = true
    
    init() {
        NetworkAccess.shared.getVideos(completion: { result in
            switch result {
            case .success(let videoData):
                self.videos = videoData
                if videoData.count > 0 {
                    self.index = 0
                }
            case .failure(let error):
                self.videos = []
                self.index = -1
                self.playing = false
            }
        })
    }
    
    var videoTitle: String {
        guard let index = index else {
            return "Loading Videos"

        }
        
        if index == -1 {
            return "Failed to load videos"
        } else {
            let videoData = videos[index]
            return videoData.title
        }
    }
    
    var videoURL: URL? {
        guard let index = index,
              index != -1 else {
            return nil
        }
        
        let videoData = videos[index]
        return URL(string: videoData.fullURL)
    }
    
    var videoAuthor: String? {
        guard let index = index,
              index != -1 else {
            return nil
        }
        
        let videoData = videos[index]
        return videoData.author.name
    }
    
    var videoMarkdown: String? {
        guard let index = index,
              index != -1 else {
            return nil
        }
        
        let videoData = videos[index]
        return videoData.descriptionMarkdown
    }


}
