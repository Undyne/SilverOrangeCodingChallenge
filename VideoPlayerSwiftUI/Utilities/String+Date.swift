//
//  String+Date.swift
//  VideoPlayerSwiftUI
//
//  Created by Greg Rodrigues on 2024-01-14.
//

import Foundation

public extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        if contains(".") {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
}
