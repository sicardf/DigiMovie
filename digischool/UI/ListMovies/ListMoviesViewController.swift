//
//  ViewController.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListMoviesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var page = 0
    
    fileprivate var viewModel = ListMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
        searchBar.delegate = self
        
      //  request()
       // tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configTableView() {
        
        tableView?.dataSource = viewModel
        tableView?.delegate = self
        
        tableView?.keyboardDismissMode = .onDrag
        
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        tableView?.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        
        
        
    }
    
    func request(search: String) {
        API().req(.getSearch, params: ["s" : search, "page": "\(page + 1)"]) { (success, data) in
            if success {
                self.page += 1
                guard let listMovies = ListMovies(data: data!) else {
                    return
                }
                self.viewModel.addMovies(movies: listMovies.movies)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
//    @IBAction func touch(_ sender: Any) {
//        request()
//    }
    
}

extension ListMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModel.items.count - 1
        if indexPath.row == lastItem {
            request(search: searchBar.text!)
        }
    }

}

extension ListMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.page = 0
        viewModel.clean()
        self.request(search: searchText)
    }
}

