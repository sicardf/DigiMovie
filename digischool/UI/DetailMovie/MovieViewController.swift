//
//  DetailMovieViewController.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class MovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var criticsRatingControl: RatingControl!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var castingLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    
    var IMDbID: String!
    var viewModel: MovieViewModel! {
        didSet {
            self.displayModelView()
//            self.viewModel
//            self.viewModel.greetingDidChange = { [unowned self] viewModel in
//                self.greetingLabel.text = viewModel.greeting
//            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.request()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func request() {
        API().req(.getSearchIMDbID, params: ["i" : self.IMDbID]) { (success, data) in
            if success {
                guard let movie = MovieModel(data: data!) else {
                    return
                }
                self.viewModel = MovieViewModel(movie: movie.movie)
                //self.displayModelView()
            }
        }
    }
    
    private func displayModelView() {
        titleLabel.text = viewModel.item.title
        posterImageView?.contentMode = .scaleAspectFit
        posterImageView?.af_setImage(withURL: URL(string: viewModel.item.poster)!)
        releasedDateLabel.text = viewModel.item.releasedDate
        criticsRatingControl.starCount = 5
        if let numberFromCode = Float(viewModel.item.imdbRating) {
            criticsRatingControl.rating = Int(numberFromCode) / 2
        }
        synopsisLabel.text = viewModel.item.plot
        castingLabel.text = viewModel.item.actors
        awardsLabel.text = viewModel.item.awards
        genreLabel.text = viewModel.item.genre
        actorsLabel.text = viewModel.item.actors
        productionLabel.text = viewModel.item.production
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
