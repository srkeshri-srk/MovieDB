//
//  URLGenerator.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//  Copyright (c) 2023 SRK. All rights reserved.
//
//  This file was generated by the Shreyansh Raj Keshri 👾
//


import Foundation

final class URLGenerator {
    static func prepareURL(_ api: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: api.url.absoluteString)
        let queryItems = api.queryParams?.map({ (key, value) in
            return URLQueryItem(name: key, value: String(describing: value) )
        })
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    static func prepareURLRequest(with api: APIRequest) -> URLRequest? {
        guard let url = prepareURL(api) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = api.body
        return urlRequest
    }
}
