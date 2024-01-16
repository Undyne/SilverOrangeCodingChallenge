//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import Down

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
            Rectangle()
                .foregroundColor(.red)
            
            if (videoPlayerViewModel.showButtons || !videoPlayerViewModel.playing) {
                HStack(alignment: .center, spacing: 25) {
                    
                    Image("Previous")
                        .frame(width: 50, height: 50)
                        .background(Color(white: 0.8))
                        .cornerRadius(25)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))
                    
                    Image(videoPlayerViewModel.playing ? "Pause" : "Play")
                        .frame(width: 80, height: 80)
                        .background(Color(white: 0.8))
                        .cornerRadius(40)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))

                    Image("Next")
                        .frame(width: 50, height: 50)
                        .background(Color(white: 0.8))
                        .cornerRadius(25)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.0))
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
                    Text(videoMarkdown)
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
