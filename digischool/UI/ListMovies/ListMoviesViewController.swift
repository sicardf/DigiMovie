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
    
    private var page = 0
    private var debouncedSearch: Debouncer!
    private var viewModel: ListMoviesViewModel! {
        didSet {
            self.viewModel.listMoviesDidChange = { [unowned self] viewModel in
                self.tableViewStyleLine(viewModel.items.count)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ListMoviesViewModel()
        
        initDebouncer()
        configTableView()
        configSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initDebouncer() {
        debouncedSearch = Debouncer(delay: 0.15) {
            if let text = self.searchBar.text {
                self.page = 0
                self.viewModel.clean()
                self.request(search: text)
            }
        }
    }
    
    private func configTableView() {
        tableView?.dataSource = viewModel
        tableView?.delegate = self
        tableView?.keyboardDismissMode = .onDrag
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        tableView?.separatorStyle = .none
        
        let messageTB = UILabel(frame: CGRect(x: 0, y: 0, width: (tableView?.bounds.size.width)!, height: (tableView?.bounds.size.height)!))
        messageTB.text = "Merci de faire une recherche"
        messageTB.textAlignment = .center
        messageTB.sizeToFit()
        tableView?.backgroundView = messageTB

    }
    
    private func configSearchBar() {
        searchBar.delegate = self
    }
    
    private func request(search: String) {
        API().req(.getSearchTitle, params: ["s" : search, "page": "\(page + 1)", "type": "movie"]) { (success, data) in
            if success {
                if let data = data {
                    self.page += 1
                    guard let listMovies = ListMovies(data: data) else {
                        return
                    }
                    self.viewModel.addMovies(movies: listMovies.movies)
                }
            }
        }
    }
    
}

extension ListMoviesViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieSegue" {
            let movieViewController = segue.destination as! MovieViewController
            let indexPath = sender as! IndexPath
            movieViewController.IMDbID = viewModel.items[indexPath.row].imdbid
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModel.items.count - 1
        if indexPath.row == lastItem {
            request(search: searchBar.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "MovieSegue", sender: indexPath)
    }
    
    func tableViewStyleLine(_ countItem: Int) {
        if countItem == 0 {
            self.tableView?.separatorStyle = .none
            tableView?.backgroundView?.isHidden = false
        } else {
            self.tableView.separatorStyle = .singleLine
            tableView?.backgroundView?.isHidden = true
        }
    }
}

extension ListMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncedSearch.call()
    }
}
