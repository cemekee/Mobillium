//
//  DetailViewController.swift
//  Mobillium
//
//  Created by Cem Eke on 3.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    private let viewModel = DetailViewModel()
    var selectedMovieId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        loadData()
        
    }
    
    
}

extension DetailViewController {
    
    private func initVM(){
        viewModel.updateUI = { [weak self] in
            self?.updateUIx()
        }
    }
    
    private func loadData(){
        viewModel.fetchSelectedMovie(id: selectedMovieId ?? 0)
    }
    
    @IBAction func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateUIx(){
        let data = viewModel.getSelectedMovie()
        lblPageTitle.text = data?.title
        lblDescription.text = data?.overview
        lblRate.text = "\(data?.voteAverage ?? 0)" + "/10"
        lblDate.text = data?.releaseDate
        lblTitle.text = data?.title
        let url = URL(string: (ServiceList.imageBaseUrl) + (data?.posterPath ?? ""))
        imgView.kf.setImage(with: url)
    }
}
