//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit
import MarkdownKit

struct VideoPlayerView: View {
    
    @ObservedObject var videoPlayerViewModel = VideoPlayerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                videoPlayer

                videoDescription
            }
            .navigationBarTitle("Video Player", displayMode: .inline)
            .navigationBarColor(.black)
        }
    }
    
    
    var videoPlayer: some View {
        ZStack(alignment: .center) {
            
            Rectangle().foregroundColor(.red)

            if videoPlayerViewModel.videos.count > 0 {
                VideoPlayer(player: videoPlayerViewModel.player)
            }
            
            if (videoPlayerViewModel.showButtons || !videoPlayerViewModel.playing) {
                HStack(alignment: .center, spacing: 25) {
                    
                    Image("Previous")
                        .frame(width: 50, height: 50)
                        .background(Color(white: 0.8))
                        .cornerRadius(25)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))
                        .onTapGesture {
                            print("Previous button tapped")
                            if let index = videoPlayerViewModel.index,
                               index > 0 {
                                videoPlayerViewModel.index = index - 1
                            }
                        }
                    
                    let _ = print("videoPlayerViewModel.playing = \(videoPlayerViewModel.playing)")
                    Image(videoPlayerViewModel.playing ? "Pause" : "Play")
                        .frame(width: 80, height: 80)
                        .background(Color(white: 0.8))
                        .cornerRadius(40)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))
                        .onTapGesture {
                            if videoPlayerViewModel.playing {
                                print("Pause button tapped")
                                videoPlayerViewModel.player.pause()
                            } else {
                                print("Play button tapped")
                                videoPlayerViewModel.player.play()
                            }
                            videoPlayerViewModel.playing.toggle()
                            DispatchQueue.main.async {
                                self.videoPlayerViewModel.objectWillChange.send()
                            }
                        }

                    Image("Next")
                        .frame(width: 50, height: 50)
                        .background(Color(white: 0.8))
                        .cornerRadius(25)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))
                        .onTapGesture {
                            print("Next button tapped")
                            if let index = videoPlayerViewModel.index,
                               index < (videoPlayerViewModel.videos.count - 1) {
                                videoPlayerViewModel.index = index + 1
                            }
                        }
                }
            }
        }
        .frame(height: 210)
        .frame(maxWidth: .infinity)

    }
    
    var videoDescription: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .leading) {
                Text(videoPlayerViewModel.videoTitle)
                    .padding(.bottom, 16)
                
                if let videoAuthor = videoPlayerViewModel.videoAuthor {
                    Text(videoAuthor)
                        .padding(.bottom, 16)
                }
                
                if let videoMarkdown = videoPlayerViewModel.videoMarkdown {
                    let markdownParser = MarkdownParser()
                    let nsAttributedString = markdownParser.parse(videoMarkdown)
                    let attributedString = AttributedString(nsAttributedString)
                    let localizedMarkdown = LocalizedStringKey(videoMarkdown)
                    Text(attributedString/*localizedMarkdown*/)
                }
                
                Spacer()
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
