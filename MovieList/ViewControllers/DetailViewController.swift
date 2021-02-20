//
//  DetailViewController.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import UIKit

class DetailViewController: BaseViewController {
    var selectedMovie : Movie?
     var voteImageView = UIImageView()

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var voteContainerView: UIView!
    var scrollView = UIScrollView()
    let contrainerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavbar()
        setupUI()
        voteContainerView.layer.cornerRadius = 5
        

    }

    private func setupUI() {
        guard let selectedMovie = selectedMovie else { return }
        guard let selectedMoviePoster = selectedMovie.posterPath  else {return}
        if let fullPosterUrl  = GetPoster.getPosterUrl(width: 300, posterString: selectedMoviePoster){
            movieImageView.setRemoteImage(from: fullPosterUrl)
        }
        titleLabel.text = selectedMovie.title
        guard let selectedMovieVoteCount = selectedMovie.voteCount else { return  }
        voteCountLabel.text = "Vote Count: \(selectedMovieVoteCount)"
        descriptionLabel.text = selectedMovie.overView
     
        
    }
    private func customizeNavbar() {
        
        let rightButton  = MyBarButtonItem(buttonIconName: Assets.emptyStar.rawValue)
        if selectedMovie?.isFavourite == true {
            DispatchQueue.main.async {
                rightButton.setButtonIcon(iconName: Assets.filledStar.rawValue)

            }
        }
            else{
                DispatchQueue.main.async {
                    rightButton.setButtonIcon(iconName: Assets.emptyStar.rawValue)

                }
            }
        
        rightButton.setNavbarButtonAction {
            if self.selectedMovie?.isFavourite == false {
                self.selectedMovie?.isFavourite?.toggle()

                DispatchQueue.main.async {
                    rightButton.setButtonIcon(iconName: Assets.filledStar.rawValue)
                }
                self.selectedMovie?.addIssueToFavourites()
            }else {
                self.selectedMovie?.isFavourite?.toggle()
                DispatchQueue.main.async {
                    rightButton.setButtonIcon(iconName: Assets.emptyStar.rawValue)
                }
                self.selectedMovie?.removeFromFavourites()

            }
        
        }
        setupNavBar(right: rightButton)
    }
   
}
