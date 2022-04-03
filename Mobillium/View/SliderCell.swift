//
//  SliderCell.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit
import Kingfisher

class SliderCell: UICollectionViewCell {

    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Result?) {
        let url = URL(string: (ServiceList.imageBaseUrl) + (data?.posterPath ?? ""))
        imgView.kf.setImage(with: url)
        self.lblTitle.text = data?.title
        self.lblDescription.text = data?.overview
    }
}
