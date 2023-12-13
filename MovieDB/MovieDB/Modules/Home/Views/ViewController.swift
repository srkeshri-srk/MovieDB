//
//  ViewController.swift
//  MovieDB
//
//  Created by Mohit Jethwa on 08/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Home.Table.movieDetailsCell, bundle: nil), forCellReuseIdentifier: Constants.Home.Table.movieDetailsCell)
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Home.Table.movieDetailsCell, for: indexPath) as! MovieDetailsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
