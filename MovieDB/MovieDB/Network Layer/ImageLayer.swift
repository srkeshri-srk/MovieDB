//
//  ImageLayer.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 14/12/23.
//

import UIKit
import Kingfisher


class ImageLayer {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(UIImage(named: "placeholder"))
            return
        }
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure:
                completion(UIImage(named: "placeholder"))
            }
        }
    }
}
