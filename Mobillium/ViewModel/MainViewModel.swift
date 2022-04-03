//
//  MainViewModel.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation
import Alamofire

class MainViewModel {
    private var upcomingMovies: Movies?
    private var playingMovies: Movies?
    var updateUI : ()->() = {}
    
    func getUpcomingMovies() -> Movies? {
        return upcomingMovies
    }
    
    func getPlayingMovies() -> Movies? {
        return playingMovies
    }
    
    func fetchUpcomingMovies() {
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.getUpcoming , requestModel: nil, model: Movies.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let upcoming = model as! Movies
                    self?.upcomingMovies = upcoming
                    self?.updateUI()
                    
                case .failure(_):
                    break
            }
        }
        
    }
    
    func fetchPlayingMovies() {
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.nowPlaying , requestModel: nil, model: Movies.self ) { [weak self] response in
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
