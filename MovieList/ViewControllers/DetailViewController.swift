//
//  DetailViewController.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import UIKit

class DetailViewController: BaseViewController {
    var selectedMovie : Movie?
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavbar()
        descriptionLabel.sizeToFit()
        setupUI()


    }
    
    private func setupUI() {
        movieImageView.contentMode = .scaleToFill
        guard let selectedMovie = selectedMovie else { return }
        
        movieImageView.setRemoteImage(from: selectedMovie.posterPath!)
        titleLabel.text = selectedMovie.title
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
                DispatchQueue.main.async {
                    rightButton.setButtonIcon(iconName: Assets.filledStar.rawValue)

                }
                self.selectedMovie?.addIssueToFavourites()
            }else {
                DispatchQueue.main.async {
                    rightButton.setButtonIcon(iconName: Assets.emptyStar.rawValue)

                }
                self.selectedMovie?.removeFromFavourites()

            }
        
        }
        setupNavBar(right: rightButton)
    }
   
}
