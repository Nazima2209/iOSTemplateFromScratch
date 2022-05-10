//
//  ViewController.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, Identifiable {

    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViews(to: viewModel)
        setupErrorBinding()
    }

    init (viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
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

    func bindViews(to viewModel: ViewModel) {
        viewModel.output.content.drive(songsTableView.rx.items(cellIdentifier: SongDescriptionCell.description(), cellType: SongDescriptionCell.self)) { (_, song, cell) in
            cell.setDataInCell(data: song)
        }.disposed(by: disposeBag)
        
        songsTableView.rx.modelSelected(ItuneResult.self)
            .bind(to: viewModel.input.selectContent)
            .disposed(by: disposeBag)
    
        searchController.searchBar.rx
            .text
            .orEmpty
            .bind(to: viewModel.input.searchSubject)
            .disposed(by: disposeBag)
    }
    
    private func setupErrorBinding() {
        viewModel
            .output
            .error.asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] error in
                guard let self = self else {
                    return
                }
                self.showAlert(alertMessage: error?.description ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(alertMessage:String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
