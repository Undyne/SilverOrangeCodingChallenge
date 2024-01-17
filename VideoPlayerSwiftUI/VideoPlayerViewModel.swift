//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Greg Rodrigues on 2024-01-15.
//

import Foundation
import AVKit
import Combine

class VideoPlayerViewModel: ObservableObject {
    var videos: [VideoData] = []
    var playing: Bool = false
    var showButtons: Bool = false
    let player = AVPlayer()
    let objectWillChange = ObservableObjectPublisher()

    init() {
        NetworkAccess.shared.getVideos(completion: { result in
            switch result {
            case .success(let videoData):
                self.videos = videoData
                if videoData.count > 0 {
                    self.index = 0
                    self.showButtons = true
                }
            case .failure(_):
                self.videos = []
                self.index = -1
                self.playing = false
            }
        })
    }
    
    var index: Int? = nil {
        didSet {
            print("Index set to \(String(describing: index))")
            setVideo(index)
        }
    }

    func setVideo(_ index: Int?) {
        guard let index = index else {
            videoTitle = "Loading Videos"
            videoURL = nil
            videoAuthor = nil
            videoMarkdown = nil
            return
        }
        
        if index == -1 {
            videoTitle = "Failed to load videos"
            videoURL = nil
            videoAuthor = nil
        } else {
            let videoData = videos[index]
            videoTitle = videoData.title
            videoURL = URL(string: videoData.fullURL)
            videoAuthor = videoData.author.name
            videoMarkdown = videoData.descriptionMarkdown
            playing = false
            player.pause()
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var videoTitle: String = "Loading Videos"
    var videoURL: URL? = nil {
        didSet {
            if let videoURL = videoURL {
                print("videoURL = \(videoURL)")
                player.replaceCurrentItem(with: AVPlayerItem(url: videoURL))
                player.pause()
            }
        }
    }
    var videoAuthor: String? = nil
    var videoMarkdown: String? = nil
}
