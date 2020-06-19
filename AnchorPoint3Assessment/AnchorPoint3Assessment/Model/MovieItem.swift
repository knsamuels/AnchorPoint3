//
//  MovieItem.swift
//  AnchorPoint3Assessment
//
//  Created by Kristin Samuels  on 6/19/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
     
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    let results: [MovieItem]
}

struct MovieItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case movieTitle = "title"
        case movieRating = "vote_average"
        case summary = "overview"
        case posterPath = "poster_path"
    }
    let movieTitle: String
    let movieRating:  Double
    let summary: String
    let posterPath: String?
}
