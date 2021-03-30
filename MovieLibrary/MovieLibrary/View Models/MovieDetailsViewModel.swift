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
            self.bindMoviesViewModelToController()
        }
    }
    
    private(set) var recommendations : Movies! {
        didSet {
            self.bindMoviesViewModelToController()
        }
    }
    
    var bindMoviesViewModelToController : (() -> ()) = {}
    
    init(id: Int) {
        super.init()
        self.apiClient = APIClient()
        getMovieDetails(id: id)
        getListOfRecommendations(id: id)
    }
    
    func getMovieDetails(id: Int) {
        self.apiClient.fetchMovieDetails(id) { (details, error) in
            self.movieDetails = details
        }
    }
    
    func getListOfRecommendations(id: Int) {
        self.apiClient.fetchRecommendationsList(id, { (movies, error)  in
            self.recommendations = movies
        })
    }
    
    func getImageAtURL(urlString: String,_ completionHandler: @escaping(_ data:Data?) -> Void) {
        self.apiClient.getImage(url: URL(string: urlString)!) {data in
            completionHandler(data)
        }
    }
}
