//
//  ListMoviesViewModel.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import UIKit

//protocol ListEventViewModelItem {
//    var sectionTitle: String { get }
//    var rowCount: Int { get }
//    var events: [EventViewModelEventItem] { get set }
//    var date: Date { get }
//}

class ListMoviesViewModel: NSObject {
    var items = [MoviesViewModelMovieItem]()
    
//    init() {
//        super.init()
//    }
    
    func addMovies(movies: [Movie]) {
        for item in movies {

            if let title = item.title, let imdbid = item.imdbid, let poster = item.poster, let type = item.type, let year = item.year {
                print(title)
                let movie = MoviesViewModelMovieItem(title: title,
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
        print(items.count)
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
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return items[section].sectionTitle
//    }
    
}

class MoviesViewModelMovieItem {
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

//class ListEventViewModelEventItem: ListEventViewModelItem {
//    var events = [EventViewModelEventItem]()
//    var date: Date
//
//    var sectionTitle: String {
//        return date.convertToString(formatType: "MM/yyyy")
//    }
//
//    var rowCount: Int {
//        return events.count
//    }
//
//    init(date: Date) {
//        self.date = date
//    }
//}
//
//class EventViewModelEventItem {
//    var dateStart: Date
//    var dateEnd: Date
//    var title: String
//    var content: String
//    var address: Address
//    var excerpt: String?
//    var icon: String?
//
//    init(dateStart: Date, dateEnd: Date, title: String, content: String, address: Address, excerpt: String?, icon: String?) {
//        self.dateStart = dateStart
//        self.dateEnd = dateEnd
//        self.title = title
//        self.content = content
//        self.address = address
//        self.excerpt = excerpt
//        self.icon = icon
//    }
//}

