//
//  UpcomingMovies.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation

struct Upcoming: Codable {
    let results: [Result]
}

struct Result: Codable {
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case overview
    }
}
