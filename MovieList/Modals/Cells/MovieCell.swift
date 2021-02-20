//
//  MovieCell.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit

class MovieCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var containerViewForLabels: UIView!
    var movie: Movie? {
        didSet{
            setData(movie: movie)
        
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        movieImageView?.image = UIImage()
        super.prepareForReuse()
        
    }
    func setupStars() {
        if let isFavourite = movie?.isFavouriteMovie() {
            if isFavourite {
                starButton.isHidden = false
            }else {
                starButton.isHidden = true
            }
        }
        
    }
    func setData(movie: Movie?) {
        setupStars()
        movieImageView.layer.cornerRadius = 5
        containerViewForLabels.layer.cornerRadius = 5
        prepareForReuse()
        movieTitleLabel.text = movie?.title
        if let movieImageUrl = movie?.posterPath {
            if   let fullPosterUrl =  GetPoster.getPosterUrl(width: 300, posterString: movieImageUrl){
                movieImageView.setRemoteImage(from: fullPosterUrl)

            }
        }
    }
    
}
