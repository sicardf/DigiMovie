//
//  ListMoviesModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation
import SwiftyJSON

enum typeMovie {
    case movie
    case serie
    case episode
}

class ListMovies {
    
    var movies = [MovieSearch]()
    var lastPage = 0
    
    init?(data: Data) {
        do {
            let json = try JSON(data: data)
            for item in json["Search"] {
                let movie = MovieSearch(json: item.1)
                movies.append(movie)
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return
        }
    }
    
    func addPage(data: Data, page: Int) {
        do {
            let json = try JSON(data: data)
            for item in json["Search"] {
                let movie = MovieSearch(json: item.1)
                movies.append(movie)
            }
            lastPage = page
            //events = events.sorted(by: { $0.dateStart! < $1.dateStart! })
        } catch {
            print("Error deserializing JSON: \(error)")
            return
        }
    }
    
    func clean() {
        movies = []
        lastPage = 0
    }
}

class MovieSearch {
    var title: String?
    var imdbid: String?
    var poster: String?
    var type: String?
    var year: String?
    
    init(json: JSON) {
        self.title = json["Title"].string
        self.imdbid = json["imdbID"].string
        self.poster = json["Poster"].string
        self.type = json["Type"].string
        self.year = json["Year"].string
    }
}
