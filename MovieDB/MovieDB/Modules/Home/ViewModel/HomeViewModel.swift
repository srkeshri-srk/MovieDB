//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import UIKit
import Kingfisher


protocol MovieDetailsProtocol {
    var count: Int { get }
    
    static func builder() -> HomeViewModel
    func fetchMovieData(completion: @escaping ()->Void)
    func getContentsInfo(index: Int) -> Results?
    func addTofavourite(for key: String, data: Results)
    func getDatafromFavourite(for key: String, completion: @escaping () -> Void)
    func fetchImage(index: Int) -> UIImage
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
                print("Error - ", failure)
                self.fetchDatafromJSON(completion: completion)
            }
        }
    }
    
    private func fetchDatafromJSON(completion: @escaping () -> Void) {
        guard let jsonData = JSONReader.readLocalJSONFile(for: .MovieDetails) else {
            completion()
            return
        }
        
        guard let result: HomeModel = JSONParser().decode(jsonData) else {
            completion()
            return
        }
                
        self.configureData(model: result)
        completion()
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
    
    func fetchImage(index: Int) -> UIImage {
//        guard let imagePath = URL(string: Constants.Home.imageURLPath + (data?[index].backdropPath ??  "/1X7vow16X7CnCoexXh4H4F2yDJv.jpg")) else {
//            return UIImage(named: "placeholder")!
//        }
                
//        KingfisherManager.shared.retrieveImage(with: imagePath) { result in
//            switch result {
//            case .success(let data):
//                return data.image
//            case .failure(let error):
//                print(error)
//                UIImage(named: "placeholder")
//            }
//        }

        return UIImage()
    }


}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(networkLayerServices: NetworkLayerServices())
        return homeVM
    }
}
