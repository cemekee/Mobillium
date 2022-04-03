//
//  UpcomingMovies.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation

struct Movies: Codable {
    var results: [Result]
}

struct Result: Codable {
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let overview: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case overview
        case id
    }
}
