//
//  MainViewModel.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation
import Alamofire

class MainViewModel {
    private var upcomingMovies: Upcoming?
    private var playingMovies: Upcoming?
    var updateUI : ()->() = {}
    
    func getUpcomingMovies() -> Upcoming? {
        return upcomingMovies
    }
    
    func fetchUpcomingMovies() {
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.getUpcoming , requestModel: nil, model: Upcoming.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let upcoming = model as! Upcoming
                    self?.upcomingMovies = upcoming
                    self?.updateUI()
                    
                case .failure(_):
                    break
            }
        }
    }
    
    func fetchPlayingMovies() {
        NetworkManager.instance.fetch(HTTPMethod.get, url: ServiceList.nowPlaying , requestModel: nil, model: Upcoming.self ) { [weak self] response in
                switch(response)
                {
                case .success(let model):
                    let upcoming = model as! Upcoming
                    self?.upcomingMovies = upcoming
                    self?.updateUI()
                    
                case .failure(_):
                    break
            }
        }
    }
    
}
