//
//  JSONReader.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 14/12/23.
//

import Foundation


enum JSONFiles: String {
    case MovieDetails = "MovieDetailsJSON"
}


class JSONReader {
    static func readLocalJSONFile(for fileName: JSONFiles) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: fileName.rawValue, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    static func fetchDatafromJSON<T: Codable>(for fileName: JSONFiles, completion: @escaping (_ result: Result<T, NetworkError>) -> Void) {
        let jsonData = JSONReader.readLocalJSONFile(for: fileName)
        
        if let data = jsonData {
            if let result: T = JSONParser().decode(data) {
                completion(.success(result))
            } else {
                completion(.failure(.dataCantParse))
            }
        }
    }
}
