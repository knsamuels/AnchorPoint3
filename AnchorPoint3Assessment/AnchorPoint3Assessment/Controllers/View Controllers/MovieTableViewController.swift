//
//  MovieTableViewController.swift
//  AnchorPoint3Assessment
//
//  Created by Kristin Samuels  on 6/19/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet var movieSearchBar: UISearchBar!
    
    var movieItems: [MovieItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieItems.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        let searchResult = movieItems[indexPath.row]
        cell.movieItem = searchResult
        cell.updateViews()
        return cell
    }

}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        MovieController.fetchMovieItem(searchTerm: searchTerm) { (result) in
            switch result {
            case .success(let movies):
                self.movieItems = movies
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
