//
//  ServiceList.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation

struct ServiceList {
    static let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    static let getUpcoming: String = "https://api.themoviedb.org/3/movie/upcoming?api_key=3ca78040cf56562fb8430cd596a04b68&language=en-US"
    static let nowPlaying: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=3ca78040cf56562fb8430cd596a04b68&language=en-US"
    static let getDetail: String = "https://api.themoviedb.org/3/movie/{MOVIEID}?api_key=3ca78040cf56562fb8430cd596a04b68&language=en-US"
    static func getDetail(movieId: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieId)?api_key=3ca78040cf56562fb8430cd596a04b68&language=en-US"
    }

}
