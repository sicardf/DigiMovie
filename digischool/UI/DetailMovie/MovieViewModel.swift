//
//  MovieViewModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/22/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation

class MovieViewModel: NSObject {
    
    var item: MovieViewModelItem!
    
    init(movie: Movie) {
        super.init()
        if let title = movie.title, let releasedDate = movie.releasedDate, let imdbRating = movie.imdbRating, let plot = movie.plot, let actors = movie.actors, let poster = movie.poster, let awards = movie.awards, let genre = movie.genre, let writer = movie.writer, let production = movie.production {
            let movie = MovieViewModelItem(title: title,
                                           releasedDate: releasedDate,
                                           imdbRating: imdbRating,
                                           plot: plot,
                                           actors: actors,
                                           poster: poster,
                                           awards: awards,
                                           genre: genre,
                                           writer: writer,
                                           production: production)
            item = movie
        }
    }
}

class MovieViewModelItem {
    var title: String
    var releasedDate: String
    var imdbRating: String
    var plot: String
    var actors: String
    var poster: String
    var awards: String
    var genre: String
    var writer: String
    var production: String

    
    init(title: String, releasedDate: String, imdbRating: String, plot: String, actors: String, poster: String, awards: String, genre: String, writer: String, production: String) {
        self.title = title
        self.releasedDate = releasedDate
        self.imdbRating = imdbRating
        self.plot = plot
        self.actors = actors
        self.poster = poster
        self.awards = awards
        self.genre = genre
        self.writer = writer
        self.production = production
    }
    
}

