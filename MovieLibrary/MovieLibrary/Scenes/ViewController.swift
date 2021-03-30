//
//  ViewController.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var moviesTableView: UITableView!
    private var moviesViewModel : MoviesViewModel!
    
    private var dataSource : MoviesTableViewDataSource<MovieTableViewCell, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.moviesTableView.isHidden = true
        self.activityIndicator.startAnimating()
        self.updateUI()
    }
    
    // updateUI() updates UI based on thee callback from the view model
    func updateUI(){
        self.moviesViewModel = MoviesViewModel()
        self.moviesViewModel.bindMoviesViewModelToController = {
            self.updateDataSource()
            DispatchQueue.main.async() {
                self.moviesTableView.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // updateDataSource() updates the data required to show the lis of movies
    func updateDataSource(){
        if let moviesData = self.moviesViewModel.moviesData {
            self.dataSource = MoviesTableViewDataSource(cellIdentifier: "MoviesCell", items: moviesData.movies, configureCell: { (cell, movie) in
                cell.movieName.text = "\(movie.name)"
                cell.year.text = "\(movie.year)"
                self.moviesViewModel.getImageAtURL(urlString: movie.thumbnail) { (data) in
                    if let imageData = data {
                        DispatchQueue.main.async() {
                            cell.thumbnail.image = UIImage(data: imageData)
                            cell.thumbnail.layer.cornerRadius = cell.thumbnail.frame.width/2.0
                            cell.thumbnail.clipsToBounds = true
                        }
                    }
                }
            }, didSelectMovie: { (movie) in
                let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "details")
                    as? MovieDetailsViewController
                detailsViewController?.movieId = movie.id
                self.navigationController?.pushViewController(detailsViewController!, animated: true)
            })
            
            DispatchQueue.main.async {
                self.moviesTableView.dataSource = self.dataSource
                self.moviesTableView.delegate = self.dataSource
                self.moviesTableView.reloadData()
            }
        }
    }
}
