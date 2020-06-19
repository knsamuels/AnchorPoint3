//
//  MovieController.swift
//  AnchorPoint3Assessment
//
//  Created by Kristin Samuels  on 6/19/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit
//https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
struct StringConstants {
    fileprivate static let baseURLString = "https://api.themoviedb.org/3/search/movie"
    fileprivate static let apiKey = "api_key"
    fileprivate static let apiValue = "9c80381364bbee700141c1bfb385a462"
    fileprivate static let movieComponent = "query"
}

class MovieController {
    
    static func fetchMovieItem(searchTerm: String, completion: @escaping (Result<[MovieItem], MovieError>) -> Void) {
        
        guard let baseURL = URL(string: StringConstants.baseURLString) else { return completion(.failure(.invaildURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let movieSearchQuery = URLQueryItem(name: StringConstants.movieComponent, value: searchTerm)
        let apiQueryItem = URLQueryItem(name: StringConstants.apiKey, value: StringConstants.apiValue)
        
        components?.queryItems = [movieSearchQuery, apiQueryItem]
        guard let finalURL = components?.url else {return completion(.failure(.invaildURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            do {
                print(data)
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let movieItem = topLevelDictionary.results
                return completion(.success(movieItem))
                
            } catch {
                return completion(.failure(.unableToDecode(error)))
            }
        }.resume()
    }
    
    static func fetchImageFrom(url: String, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        guard let pathPrefix = URL(string: "https://image.tmdb.org/t/p/w500/") else { return
            completion(.failure(.invaildURL))
        }
        
        let imageUrl = pathPrefix.appendingPathComponent(url)
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecodeImage))}
            
            completion(.success(image))
        }.resume()
    }
}
