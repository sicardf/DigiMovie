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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
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
    
    private var _IMDbID: String!
    public var IMDbID: String {
        get {
            return _IMDbID
        }
        set {
            _IMDbID = newValue
        }
    }
    
    var viewModel: MovieViewModel! {
        didSet {
            if viewModel.item != nil {
                 self.displayModelView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(MovieViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MovieViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        contentView.isHidden = true
        request()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func request() {
        API().req(.getSearchIMDbID, params: ["i" : self._IMDbID]) { (success, data) in
            if success {
                if let data = data {
                    guard let movie = MovieModel(data: data) else {
                        return
                    }
                    self.viewModel = MovieViewModel(movie: movie.movie)
                }
            }
        }
    }
    
    private func displayModelView() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(), UIBarButtonItem(title: "IMDB", style: .plain, target: self, action: #selector(MovieViewController.openIMDB))]
        if let rating = viewModel.item.imdbRating {
            if let numberFromCode = Float(rating) {
                criticsRatingControl.starCount = 5
                criticsRatingControl.rating = Int(numberFromCode) / 2
            } else {
                criticsRatingControl.isHidden = true
            }
        }
        posterImageView?.contentMode = .scaleAspectFit
        posterImageView?.af_setImage(withURL: URL(string: viewModel.item.poster)!)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        titleLabel.text = viewModel.item.title
        releasedDateLabel.text = viewModel.item.releasedDate
        synopsisLabel.text = viewModel.item.plot
        castingLabel.text = viewModel.item.actors
        awardsLabel.text = viewModel.item.awards
        genreLabel.text = viewModel.item.genre
        actorsLabel.text = viewModel.item.actors
        productionLabel.text = viewModel.item.production ?? "N/A"
        contentView.isHidden = false
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func openIMDB() {
        UIApplication.shared.open(URL(string: "http://www.imdb.com/title/" + self._IMDbID)!, options: [:], completionHandler: nil)
    }

}
