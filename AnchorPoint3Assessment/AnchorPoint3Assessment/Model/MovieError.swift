//
//  Error.swift
//  AnchorPoint3Assessment
//
//  Created by Kristin Samuels  on 6/19/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation

enum MovieError: LocalizedError {
    
    case invaildURL
    case thrownError(Error)
    case noData
    case unableToDecode(Error)
    case unableToDecodeImage
  
    var errorDescription: String? {
        switch self {
        case .invaildURL:
            return "The server failed to reach the necessary URL"
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .noData:
            return "There was no date found"
        case .unableToDecode(let error):
            return "\(error) There was an error when decoding the movie items"
        case .unableToDecodeImage:
            return "Unable to get the image for the movie item"
        }
    }
}
