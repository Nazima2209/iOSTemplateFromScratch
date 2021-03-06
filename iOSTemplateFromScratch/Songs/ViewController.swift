//
//  ViewController.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // For rendering Dummy data
        viewModel.initialiseArray()
        // Do any additional setup after loading the view.
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    let songsTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(SongDescriptionCell.self, forCellReuseIdentifier: SongDescriptionCell.description())
        tableview.register(NoResultsCell.self, forCellReuseIdentifier: NoResultsCell.description())
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    func setupUI() {
        self.view.addSubview(songsTableView)
        let margins = view.layoutMarginsGuide
        songsTableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        songsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        songsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        songsTableView.dataSource = self
        songsTableView.delegate = self
        addSearchBarToNav()
    }
    
    func addSearchBarToNav() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}

extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songsResult.isEmpty ? 1 : viewModel.songsResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.songsResult.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoResultsCell.description()) as? NoResultsCell else { return UITableViewCell() }
            cell.noResultLabel.text = "You haven't searched anything yet"
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongDescriptionCell.description(), for: indexPath) as? SongDescriptionCell else { return UITableViewCell() }
        cell.songTitleLabel.text = viewModel.songsResult[indexPath.row].title
        cell.songDescriptionLabel.text = viewModel.songsResult[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.songsResult.isEmpty {
            return tableView.frame.size.height
        }
        return UITableView.automaticDimension
    }
}

