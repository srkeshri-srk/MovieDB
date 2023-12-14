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
    @IBOutlet weak var detailsView: UIView!
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
        artworkImageView.layer.cornerRadius = 10.0
        artworkImageView.layer.masksToBounds = true
        detailsView.layer.cornerRadius = 10.0
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        detailsView.layer.masksToBounds = true
        
        detailsView.layer.borderColor = UIColor.blue.withAlphaComponent(0.4).cgColor
        detailsView.layer.borderWidth = 1.0
    }
        
    func configureUI(data: Results?) {
        guard let data = data else { return }
        self.data = data
        
        titleLabel.text = data.originalTitle
        ratingLabel.text = String(format: "%.1f/10", data.voteAverage ?? 0.0)
        
        ImageLayer.loadImage(from: Constants.Home.imageURLPath + (data.posterPath ??  "/dB6Krk806zeqd0YNp2ngQ9zXteH.jpg")) { image in
            self.artworkImageView.image = image
        }
    }
    
    @IBAction func favouriteButtonTapAction(_ sender: UIButton) {
        guard let data = data else { return }
        delegate?.favouriteButtonTapped(data: data)
    }
    
}
