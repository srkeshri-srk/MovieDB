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
    func addTofavourite(for key: String, data: Results)
    func getDatafromFavourite(for key: String, completion: @escaping () -> Void)
}

class HomeViewModel: MovieDetailsProtocol {
    private let networkLayerServices: NetworkLayerServices
    private var homeData: [Results]? = [Results]()
    private var favouriteData: [String: [Results]] = [:]
    private var data: [Results]? = [Results]()

    var count: Int {
        return data?.count ?? 0
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
        self.data = homeData
    }
    
    func getContentsInfo(index: Int) -> Results? {
        guard let homeData = self.data?[index] else { return nil }
        return homeData
    }
    
    func addTofavourite(for key: String, data: Results) {
        if favouriteData[key] == nil {
            favouriteData[key] = [data]
        } else {
            favouriteData[key]?.append(data)
        }
    }
    
    func getDatafromFavourite(for key: String, completion: @escaping () -> Void) {
        guard let value = favouriteData[key] else {
            completion()
            return
        }
        
        data = value
        completion()
    }

}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(networkLayerServices: NetworkLayerServices())
        return homeVM
    }
}
