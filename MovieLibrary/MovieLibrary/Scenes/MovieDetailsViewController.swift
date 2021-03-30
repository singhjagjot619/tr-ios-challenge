//
//  MovieDetailsViewController.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie!
    private var movieDetailsViewModel : MovieDetailsViewModel!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var recommendedLabel: UILabel!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieDateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var plotLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createRecommendationsView()
        self.contentView.isHidden = true;
        self.updateUI()
    }
    
    func createRecommendationsView() {
        self.contentView.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: 600, height: 120)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.recommendedLabel.bottomAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20.0).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        scrollView.isScrollEnabled = true
    }
    
    func updateUI(){
        self.movieDetailsViewModel = MovieDetailsViewModel(id: movie.id)
        self.movieDetailsViewModel.bindMoviesViewModelToController = {
            self.updateDataSource()
            DispatchQueue.main.async {
                self.contentView.isHidden = false;
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func updateDataSource(){
        if let details = self.movieDetailsViewModel.movieDetails {
            self.movieDetailsViewModel.getImageAtURL(urlString: details.picture!) { (data) in
                
                if let imageData = data {
                    DispatchQueue.main.async() {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }
            }
            DispatchQueue.main.async() {
                self.movieNameLabel.text = details.name
                let dateString = self.formatDate(interval: details.releaseDate!)
                
                self.movieDateLabel.text = "Date of Release: \(dateString)"
                self.descriptionLabel.text = details.description!
                self.plotLabel.text = details.notes
            }
        }
        
        
        if let recommendations = self.movieDetailsViewModel.recommendations {
            for (index, recommendation) in recommendations.movies.enumerated() {
                self.movieDetailsViewModel.getImageAtURL(urlString: recommendation.thumbnail) { (data) in
                    
                    if let imageData = data {
                        DispatchQueue.main.async() {
                            var imageView : UIImageView
                            imageView = UIImageView(frame:CGRect(x: index * 100 + 20, y: 10, width: 100, height: 100));
                                imageView.image = UIImage(data: imageData)
                            self.scrollView.addSubview(imageView)
                        }
                    }
                }
            }
        }
    }
    
    func formatDate(interval: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
