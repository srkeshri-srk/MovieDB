//
//  ViewController.swift
//  MovieDB
//
//  Created by Mohit Jethwa on 08/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    let viewModel: MovieDetailsProtocol = HomeViewModel.builder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = Constants.Home.navTitle
        
        filterButton.layer.cornerRadius = filterButton.bounds.size.height / 2
        filterButton.layer.masksToBounds = true
    }
    
    private func fetchData() {
        viewModel.fetchMovieData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Home.Table.movieDetailsCell, bundle: nil), forCellReuseIdentifier: Constants.Home.Table.movieDetailsCell)
    }
    
    
    @IBAction func filterButtonTapAction(_ sender: UIButton) {
        
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Home.Table.movieDetailsCell, for: indexPath) as! MovieDetailsTableViewCell
        cell.configureUI(data: viewModel.getContentsInfo(index: indexPath.row))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.width / 2
    }
}


extension ViewController: MovieDetailsTableViewCellProtocol {
    func favouriteButtonTapped(data: Results) {
        viewModel.addTofavourite(for: "V1", data: data)
    }
}
