//
//  DetailViewController.swift
//  Mobillium
//
//  Created by Cem Eke on 3.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var lblPageTitle: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblRate: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
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
            self?.updateUI()
        }
        viewModel.showError = {[weak self] in
            self?.showErrorPopUp()
        }
    }
    
    private func loadData(){
        viewModel.fetchSelectedMovie(id: selectedMovieId ?? 0)
    }
    
    private func updateUI(){
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

// MARK: - Actions
extension DetailViewController {
    @IBAction func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func showErrorPopUp(){
        let alert = UIAlertController(title: "Error", message: "Fetch Error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
