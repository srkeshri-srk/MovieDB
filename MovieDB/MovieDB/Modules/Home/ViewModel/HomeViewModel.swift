//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import Foundation

protocol MovieDetailsProtocol {
    var count: Int { get }
    func fetchData(completion: @escaping ()->Void)
    static func builder() -> HomeViewModel
}

class HomeViewModel: MovieDetailsProtocol {
    let urlString: String
    let networkLayerServices = NetworkLayerServices()
    var count: Int {
        return 10
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func fetchData(completion: @escaping ()->Void) {
        guard let url = URL(string: urlString) else {
            completion()
            return
        }
        
        let headerParams = ["Authorization": "Bearer \(Constants.apiKey)"]
        let queryParams: [String: Any] = ["language": "en-US", "page": 1]
        
        let apiRequest = APIRequest(url: url, method: .GET, headers: headerParams, queryParams: queryParams, body: nil)
        
        print(apiRequest)
        
        networkLayerServices.dataTask(apiRequest) { (result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success(let success):
                print(success)
                completion()
            case .failure(let failure):
                print(failure)
                completion()
            }
        }
    }
    
    
}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(urlString: Constants.Home.movieDetailsURL)
        return homeVM
    }
}
