//
//  FirstCell.swift
//  Mobillium
//
//  Created by Cem Eke on 3.04.2022.
//

import UIKit

class FirstCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    var goToDetail : (Int)->() = {_ in }
    private var data: [Result]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
    }
}

extension FirstCell{
    func configure(data:[Result]?) {
        self.data = data
    }
}
extension FirstCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        cell.configure(data: self.data?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToDetail(data?[indexPath.row].id ?? 0)
        //self.goToDetail(696806)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//        vc?.selectedMovieId = data?[indexPath.row].id
//        self.navigationController?.pushViewController(vc!, animated: true)
        }
}

extension FirstCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 1 - gridLayout.minimumInteritemSpacing
            let heightPerItem = collectionView.frame.height / 1 - gridLayout.minimumInteritemSpacing
            return CGSize(width:widthPerItem, height:heightPerItem)
        
    }
}
