//
//  MovieDetailsViewModel.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import Foundation
import UIKit

class MovieDetailsViewModel : NSObject {
    
    private var apiClient : APIClient!
    let listUrl = "/list.json"

    private(set) var movieDetails : MovieDetails! {
        didSet {
            self.bindMovieDetailsModelToController()
        }
    }
    
    private(set) var recommendations : Movies! {
        didSet {
            self.bindMovieDetailsModelToController()
        }
    }
    
    var bindMovieDetailsModelToController : (() -> ()) = {}
    
    init(id: Int) {
        super.init()
        self.apiClient = APIClient()
        getMovieDetails(id: id)
        getListOfRecommendations(id: id)
    }
    
    // getMovieDetails(_ id) responsible to fetch movie details for the given movie id from the API
    func getMovieDetails(id: Int) {
        self.apiClient.fetchMovieDetails(id) { (details, error) in
            self.movieDetails = details
        }
    }
    
    // getListOfRecommendations(_ id) responsible to fetch list of movie recommendations for the given movie id from the API
    func getListOfRecommendations(id: Int) {
        self.apiClient.fetchRecommendationsList(id, { (movies, error)  in
            self.recommendations = movies
        })
    }
    
    // getImageAtURL(_ urlString,  _ completionHandler) gets the image data from the Url string
    func getImageAtURL(urlString: String, _ completionHandler: @escaping(_ data:Data?) -> Void) {
        self.apiClient.getImage(url: URL(string: urlString)!) {data in
            completionHandler(data)
        }
    }
}
