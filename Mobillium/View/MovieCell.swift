//
//  MovieCell.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        imgView.layer.cornerRadius = 6
        imgView.clipsToBounds = true
    }
    
    func configure(data:Result) {
        let url = URL(string: (ServiceList.imageBaseUrl) + (data.posterPath ?? ""))
            imgView.kf.setImage(with: url)
        self.lblTitle.text = data.title
        self.lblDescription.text = data.overview
        self.lblDate.text = data.releaseDate
        }
}
