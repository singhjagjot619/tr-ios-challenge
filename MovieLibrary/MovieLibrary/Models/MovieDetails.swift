//
//  MovieDetails.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

struct MovieDetails: Decodable {
    let id : Int
    let name: String?
    let description: String?
    let notes: String?
    let picture: String?
    let releaseDate: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "Description"
        case notes
        case picture
        case releaseDate
    }
}

