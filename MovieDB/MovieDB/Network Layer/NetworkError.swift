//
//  NetworkError.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//  Copyright (c) 2023 SRK. All rights reserved.
//
//  This file was generated by the Shreyansh Raj Keshri 👾
//


import Foundation

enum NetworkError: Error {
    case urlNotFound
    case dataCantParse
    case noDataFound
    case httpFailure
}
