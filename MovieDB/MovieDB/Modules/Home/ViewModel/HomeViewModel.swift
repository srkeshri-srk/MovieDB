//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import Foundation

protocol MovieDetailsProtocol {
    var count: Int { get }
    
    static func builder() -> HomeViewModel
    func fetchMovieData(completion: @escaping ()->Void)
    func getContentsInfo(index: Int) -> Results?
}

class HomeViewModel: MovieDetailsProtocol {
    private let networkLayerServices: NetworkLayerServices
    private var homeData: [Results]? = [Results]()

    var count: Int {
        return homeData?.count ?? 0
    }
    
    init(networkLayerServices: NetworkLayerServices) {
        self.networkLayerServices = networkLayerServices
    }
    
    func fetchMovieData(completion: @escaping ()->Void) {
        guard let url = URL(string: Constants.Home.movieDetailsURL) else {
            completion()
            return
        }
        
        let headerParams = ["Authorization": "Bearer \(Constants.apiKey)"]
        let queryParams: [String: Any] = ["language": "en-US", "page": 1]
        let apiRequest = APIRequest(url: url, method: .GET, headers: headerParams, queryParams: queryParams, body: nil)
        
        networkLayerServices.dataTask(apiRequest) { (result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success(let success):
                self.configureData(model: success)
                completion()
            case .failure(let failure):
                print(failure)
                completion()
            }
        }
    }
    
    private func configureData(model: HomeModel) {
        guard let data = model.results else { return }
        self.homeData?.append(contentsOf: data)
    }
    
    func getContentsInfo(index: Int) -> Results? {
        guard let homeData = self.homeData?[index] else { return nil }
        return homeData
    }
    

}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(networkLayerServices: NetworkLayerServices())
        return homeVM
    }
}
