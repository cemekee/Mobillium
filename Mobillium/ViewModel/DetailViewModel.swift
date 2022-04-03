//
//  DetailViewModel.swift
//  Mobillium
//
//  Created by Cem Eke on 3.04.2022.
//

import Foundation
import Alamofire

class DetailViewModel {
    private var selectedMovie: Result?
    //var selectedMovieId: Int?
    var updateUI : ()->() = {}
    var showError: ()->() = {}
    
    func getSelectedMovie() -> Result? {
        return selectedMovie
    }
    
    func fetchSelectedMovie(id: Int) {
        let url = ServiceList.getDetail(movieId: id ?? 0)
        NetworkManager.instance.fetch(HTTPMethod.get, url: url , params: nil, model: Result.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let selectedMovie = model as! Result
                    self?.selectedMovie = selectedMovie
                    self?.updateUI()
                case .failure(_):
                    self?.showError()
                    break
            }
        }
    }
    
}
