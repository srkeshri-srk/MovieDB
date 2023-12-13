//
//  ViewController.swift
//  MovieDB
//
//  Created by Mohit Jethwa on 08/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: MovieDetailsProtocol = HomeViewModel.builder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
        setupTableView()
    }
    
    private func setupUI() {
        
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

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Home.Table.movieDetailsCell, for: indexPath) as! MovieDetailsTableViewCell
        cell.configureUI(data: viewModel.getContentsInfo(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310.0
    }
}
