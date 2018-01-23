//
//  MovieModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/22/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieModel {
    
    var movie: Movie!
    
    init?(data: Data) {
        do {
            let json = try JSON(data: data)
            self.movie = Movie(json: json)
        } catch {
            print("Error deserializing JSON: \(error)")
            return
        }
    }
}


class Movie {
    
    var title: String?
    var releasedDate: String?
    var imdbRating: String?
    var plot: String?
    var actors: String?
    var poster: String?
    var awards: String?
    var genre: String?
    var writer: String?
    var production: String?
    
    init(json: JSON) {
        self.title = json["Title"].string
        self.releasedDate = json["Released"].string
        self.imdbRating = json["imdbRating"].string
        self.plot = json["Plot"].string
        self.actors = json["Actors"].string
        self.poster = json["Poster"].string
        self.awards = json["Awards"].string
        self.genre = json["Genre"].string
        self.writer = json["Writer"].string
        self.production = json["Production"].string
    }
}
