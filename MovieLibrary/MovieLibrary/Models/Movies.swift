//
//  Movies.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

struct Movies: Decodable{
  var movies: [Movie]
 
  enum CodingKeys: String, CodingKey {
    case movies
  }
}
