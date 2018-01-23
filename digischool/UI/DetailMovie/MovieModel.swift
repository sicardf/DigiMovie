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






//
//struct Person { // Model
//    let firstName: String
//    let lastName: String
//}
//
//protocol GreetingViewModelProtocol: class {
//    var greeting: String? { get }
//    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? { get set } // function to call when greeting did change
//    init(person: Person)
//    func showGreeting()
//}
//
//class GreetingViewModel : GreetingViewModelProtocol {
//    let person: Person
//    var greeting: String? {
//        didSet {
//            self.greetingDidChange?(self)
//        }
//    }
//    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?
//    required init(person: Person) {
//        self.person = person
//    }
//    func showGreeting() {
//        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
//    }
//}
//
//class GreetingViewController : UIViewController {
//    var viewModel: GreetingViewModelProtocol! {
//        didSet {
//
//            self.viewModel.greetingDidChange = { [unowned self] viewModel in
//                self.greetingLabel.text = viewModel.greeting
//            }
//        }
//    }
//    let showGreetingButton = UIButton()
//    let greetingLabel = UILabel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.showGreetingButton.addTarget(self.viewModel, action: "showGreeting", forControlEvents: .TouchUpInside)
//    }
//    // layout code goes here
//}
//// Assembling of MVVM
//let model = Person(firstName: "David", lastName: "Blaine")
//let viewModel = GreetingViewModel(person: model)
//let view = GreetingViewController()
//view.viewModel = viewModel

