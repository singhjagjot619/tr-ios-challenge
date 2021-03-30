//
//  Movie.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

struct Movie: Decodable {
  var id: Int
  var name: String
  var thumbnail: String
  var year: Int
 
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case thumbnail
    case year
  }
}
