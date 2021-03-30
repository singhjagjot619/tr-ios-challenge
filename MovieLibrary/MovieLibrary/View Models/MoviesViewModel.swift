//
//  MoviesViewModel.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import Foundation
import UIKit

class MoviesViewModel : NSObject {
    
    private var apiClient : APIClient!
    let listUrl = "/list.json"

    private(set) var moviesData : Movies! {
        didSet {
            self.bindMoviesViewModelToController()
        }
    }
    
    var bindMoviesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiClient = APIClient()
        getListOfMovies()
    }
    
    // getMovieDetails() responsible to fetch list of movies from the API
    func getListOfMovies() {
        self.apiClient.fetchMoviesList(listUrl, { (movies, error)  in
            self.moviesData = movies
        })
    }
    
    // getImageAtURL(_ urlString,  _ completionHandler) gets the image data from the Url string
    func getImageAtURL(urlString: String,_ completionHandler: @escaping(_ data:Data?) -> Void) {
        self.apiClient.getImage(url: URL(string: urlString)!) {data in
            completionHandler(data)
        }
    }
}
