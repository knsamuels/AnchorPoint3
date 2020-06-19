//
//  MovieTableViewCell.swift
//  AnchorPoint3Assessment
//
//  Created by Kristin Samuels  on 6/19/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  // Mark: outlets
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieRatingLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    
    
    // Mark: Properties
    var movieItem: MovieItem?
    
    func updateViews (){
        var url: String?
        
        if let movie = movieItem {
            movieTitleLabel.text = movie.movieTitle
            movieRatingLabel.text = String(movie.movieRating)
            summaryLabel.text = movie.summary
            url = movie.posterPath
        }
        self.movieImageView.image = nil
        
        if let url = url {
            MovieController.fetchImageFrom(url: url) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.movieImageView.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
