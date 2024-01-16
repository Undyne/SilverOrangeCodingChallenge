//
//  NetworkAccess.swift
//  VideoPlayerSwiftUI
//
//  Created by Greg Rodrigues on 2024-01-14.
//

import Foundation

import Foundation

enum ServerError: Error {
    case error
}

class NetworkAccess {
    
    static let shared: NetworkAccess = {
        var networkAccess = NetworkAccess.init()
        return networkAccess
    }()
    
    private init () {
        
    }
    
    var inProgress: Bool = false
    var baseURL: String = "http://localhost:4000/videos"
    
    func getVideos (completion: @escaping (Result<[VideoData], Error>) -> ()) {
        guard !inProgress else {
            print("getVideos already running.  Exiting via guard")
            return
        }
        
        inProgress = true
        print("running getVideos")
        
        guard let url = URL(string: baseURL) else {
            print("Unable to form URL. Exiting via guard")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("getVideos closure running")
            self.inProgress = false
            if let jsonData = data
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let serverResponse = try decoder.decode(Array<VideoData>.self, from: jsonData)
                    completion(.success(serverResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? ServerError.error))
            }
        }.resume()
    }

}
