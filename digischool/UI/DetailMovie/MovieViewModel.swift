//
//  MovieViewModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/22/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation

class MovieViewModel: NSObject {
    
    private var _item: MovieViewModelItem!
    public var item: MovieViewModelItem! {
        get {
            return _item
        }
    }
    
    init(movie: Movie) {
        super.init()
        
        if let title = movie.title, let releasedDate = movie.releasedDate, let plot = movie.plot,
            let actors = movie.actors, let poster = movie.poster, let awards = movie.awards,
            let genre = movie.genre, let writer = movie.writer {
            
            let capture = MovieViewModelItemBuilder { (builder) in
                builder.title = title
                builder.releasedDate = releasedDate
                builder.imdbRating = movie.imdbRating
                builder.plot = plot
                builder.actors = actors
                builder.poster = poster
                builder.awards = awards
                builder.genre = genre
                builder.writer = writer
                builder.production = movie.production
            }
            _item = MovieViewModelItem(builder: capture)
        }
    }
}

class MovieViewModelItemBuilder {
    
    var title: String = "N/A"
    var releasedDate: String = "N/A"
    var imdbRating: String?
    var plot: String = "N/A"
    var actors: String = "N/A"
    var poster: String = "N/A"
    var awards: String = "N/A"
    var genre: String = "N/A"
    var writer: String = "N/A"
    var production: String?
    
    typealias BuilderClosure = (MovieViewModelItemBuilder) -> ()
    
    init() {}
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

class MovieViewModelItem {
    
    var title: String
    var releasedDate: String
    var imdbRating: String?
    var plot: String
    var actors: String
    var poster: String
    var awards: String
    var genre: String
    var writer: String
    var production: String?

    init(builder: MovieViewModelItemBuilder) {
        self.title = builder.title
        self.releasedDate = builder.releasedDate
        self.imdbRating = builder.imdbRating
        self.plot = builder.plot
        self.actors = builder.actors
        self.poster = builder.poster
        self.awards = builder.awards
        self.genre = builder.genre
        self.writer = builder.writer
        self.production = builder.production
    }
}

