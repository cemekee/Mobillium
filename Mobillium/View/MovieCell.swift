//
//  MovieCell.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        imgView.layer.cornerRadius = 6
        imgView.clipsToBounds = true
    }
    
    func configure(imgUrl:String, lblTitle:String, lblDescription:String, lblDate:String) {
        let url = URL(string: (ServiceList.imageBaseUrl) + (imgUrl))
        imgView.kf.setImage(with: url)
        self.lblTitle.text = lblTitle
        self.lblDescription.text = lblDescription
        self.lblDate.text = lblDate
    }

    
    
}
