//
//  MovieDetailsTableViewCell.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import UIKit

protocol MovieDetailsTableViewCellProtocol: AnyObject {
    func favouriteButtonTapped(data: Results)
}

class MovieDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: MovieDetailsTableViewCellProtocol?
    var data: Results?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        outerView.layer.cornerRadius = 10.0
        outerView.layer.masksToBounds = true
    }
        
    func configureUI(data: Results?) {
        guard let data = data else { return }
        self.data = data
        
        titleLabel.text = data.originalTitle
        ratingLabel.text = String(format: "%.1f/10", data.voteAverage ?? 0.0)

    }
    
    @IBAction func favouriteButtonTapAction(_ sender: UIButton) {
        guard let data = data else { return }
        delegate?.favouriteButtonTapped(data: data)
    }
    
}
