//
//  ListMoviesViewModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import UIKit

class ListMoviesViewModel: NSObject {
    var items = [MovieSearchViewModelItem]() {
        didSet {
            self.listMoviesDidChange?(self)
        }
    }
    var listMoviesDidChange: ((ListMoviesViewModel) -> ())?
    
    func addMovies(movies: [MovieSearch]) {
        for item in movies {

            if let title = item.title, let imdbid = item.imdbid, let poster = item.poster, let type = item.type, let year = item.year {
                let movie = MovieSearchViewModelItem(title: title,
                                                     imdbid: imdbid,
                                                     poster: poster,
                                                     type: type,
                                                     year: year)
                items.append(movie)
            }
        }
    }
    
    func clean() {
        items = []
    }
    
}

extension ListMoviesViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell {
            if indexPath.row < items.count {
                cell.item = items[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }
    
}

class MovieSearchViewModelItem {
    var title: String
    var imdbid: String
    var poster: String
    var type: String
    var year: String
    
    init(title: String, imdbid: String, poster: String, type: String, year: String) {
        self.title = title
        self.imdbid = imdbid
        self.poster = poster
        self.type = type
        self.year = year
    }
}

