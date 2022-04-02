//
//  SliderCell.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import UIKit
import Kingfisher

class SliderCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(imgUrl:String, lblTitle:String, lblDescription:String) {
        let url = URL(string: (ServiceList.imageBaseUrl) + (imgUrl))
        imgView.kf.setImage(with: url)
        self.lblTitle.text = lblTitle
        self.lblDescription.text = lblDescription
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
