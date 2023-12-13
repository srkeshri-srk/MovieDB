//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import Foundation

protocol MovieDetailsProtocol {
    var count: Int { get }
    func fetchData()
    static func builder() -> HomeViewModel
}

class HomeViewModel: MovieDetailsProtocol {
    var count: Int {
        return 10
    }
    
    func fetchData() {
        
    }
    
    
}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel()
        return homeVM
    }
}
