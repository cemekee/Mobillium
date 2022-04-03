//
//  MainViewModel.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation
import Alamofire

class MainViewModel {
    //private var upcomingMovies: Movies?
    private var upcomingMovies: [Result] = []
    private var playingMovies: Movies?
    var updateUI : ()->() = {}
    var showError : ()->() = {}
    
    var currentPage = 1
    var isPaginating = false

//    func getUpcomingMovies() -> Movies? {
//        return upcomingMovies
//    }
    
    func getUpcomingMovies() -> [Result] {
        return upcomingMovies
    }
    
    func getPlayingMovies() -> Movies? {
        return playingMovies
    }
    
    func removeAll(){
        upcomingMovies.removeAll()
    }
    
    func fetchUpcomingMovies(pagination: Bool = false) {
        if pagination {
            isPaginating = true
        }
        let params: Parameters = [
            "page" : currentPage
        ]
        
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.getUpcoming , params: params, model: Movies.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let upcoming = model as! Movies
                    self?.upcomingMovies.append(contentsOf: upcoming.results)
                    self?.updateUI()

                case .failure(_):
                    self?.showError()
                    break
            }
            if pagination {
                self?.isPaginating = false
            }
        }
        
//        if pagination {
//            self.isPaginating = false
//        }
    }
    
    func fetchPlayingMovies() {
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.nowPlaying , params: nil, model: Movies.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let playingMovies = model as! Movies
                    self?.playingMovies = playingMovies
                        self?.updateUI()
                case .failure(_):
                    break
            }
        }
    }
    
}
