//
//  MovieDetailsTableViewCell.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        outerView.layer.cornerRadius = 10.0
        outerView.layer.masksToBounds = true
    }
    
    private func reset() {
        artworkImageView.image = nil
        titleLabel.text = ""
        ratingLabel.text = ""
        playlistLabel.text = ""
    }
    
    func configureUI() {
        reset()
    }
    
    @IBAction func favouriteButtonTapAction(_ sender: UIButton) {
        print("Clicked")
    }
    
}
