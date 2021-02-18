//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewbottomConstraint: NSLayoutConstraint!
    var hideButton = UIButton()
    var rightButtonTapped = false
    var pageCount = 1
    var isLoading: Bool = false
    var itemSize: NSCollectionLayoutSize?
    private let MovieResource: PopularMovieResource = PopularMovieResourceImpl()
    var movieResultArray = [Results]()
    var movieList = [Movie]()
    var filteredMovies = [Movie]()
    var loadMoreButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchPopularMovies()
        collectionView.register(MovieCell.self)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout(isGrid: false)
        customizeNavBar()
        searchBar.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        registerForKeyboardNotifications(bottomConstraint: collectionViewbottomConstraint)
    }
    
   
    private func layout(isGrid: Bool) -> UICollectionViewCompositionalLayout {
      let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
        var itemCount = 1
        if isGrid == true{
            itemCount = 2
        }
       
        self.itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
          )
        var item = NSCollectionLayoutItem(layoutSize: self.itemSize!)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400)
          )
        
        if environment.container.contentSize.width > 500 {
            if isGrid == false{
                self.itemSize = NSCollectionLayoutSize (
                                    widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .fractionalHeight(0.8)
                                  )
                item = NSCollectionLayoutItem(layoutSize: self.itemSize!)
            }
        }else {
            item = NSCollectionLayoutItem(layoutSize: self.itemSize!)

        }
    
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemCount)
        if itemCount > 1 {
                  group.contentInsets.leading = 5
                  group.contentInsets.trailing = 5
                }
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets.top = 10
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                  heightDimension: .absolute(50.0))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom)
                    section.boundarySupplementaryItems = [ footer]
        return section
      }
           let config = UICollectionViewCompositionalLayoutConfiguration()
           layout.configuration = config
           return layout
    }
    
    func  getSectionAcordingToScreenSize(groupSize: NSCollectionLayoutSize,item: NSCollectionLayoutItem,itemCount: Int) -> NSCollectionLayoutSection{
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemCount)
        if itemCount > 1 {
                  group.contentInsets.leading = 5
                  group.contentInsets.trailing = 5
                }
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets.top = 10
   

        return section

    }
 
    private func customizeNavBar() {
        let rightButton  = MyBarButtonItem(buttonIconName: Assets.list.rawValue)
        rightButton.setNavbarButtonAction {
            print(self.rightButtonTapped)
            if self.rightButtonTapped == true {
                rightButton.setButtonIcon(iconName: Assets.list.rawValue)
                self.rightButtonTapped.toggle()
                self.collectionView.collectionViewLayout = self.layout(isGrid: false)

            }
            else{
                rightButton.setButtonIcon(iconName: Assets.table.rawValue)
                self.collectionView.collectionViewLayout = self.layout(isGrid: true)
                self.rightButtonTapped.toggle()

            }
            
        }
        setupNavBar(right: rightButton)
      
    }
    @objc func loadMore(){
        pageCount = pageCount+1
        fetchPopularMovies()
    }
    
    private func fetchPopularMovies() {
        MovieResource.getPopularMovies(page: pageCount) { (dataResponse) in
            switch dataResponse {
            case .success(let movieResults):
                if let unWrappedMovieResults = movieResults {
                    if unWrappedMovieResults.results != nil {
                        self.movieResultArray = unWrappedMovieResults.results!
                        for movieResult in self.movieResultArray {
                            if let moviePoster = movieResult.posterPath {
                                let movieUrl = GetPoster.getPosterUrl(width: 300, posterString: moviePoster)
                                let movie = Movie(movieTitle: movieResult.title , movieImageUrl: movieUrl, movieVoteCount: movieResult.voteCount, movieOverView: movieResult.overView)
                                self.movieList.append(movie)
                            }
                        }
                        self.filteredMovies = self.movieList
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            case .failure(_):
                break
                
            }
        }
    }
    
}
extension MovieListViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :MovieCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.movie = filteredMovies[indexPath.item]
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind ==  UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath)
            for views in footer.subviews  where views is UIButton{
                loadMoreButton = views as! UIButton
                loadMoreButton.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
            }
            return footer
        }
        return UICollectionReusableView()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
  
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    @objc func reload() {
        guard let searchText = searchBar.text else { return }
        search(searchText: searchText)
    }
    func search(searchText: String) {
        filteredMovies.removeAll()
        if searchText == "" {
            filteredMovies = movieList
            loadMoreButton.isHidden = false
        }
        else {
            loadMoreButton.isHidden = true
            self.filteredMovies = movieList.filter {$0.title!.range(of: searchText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
                let searchText = searchText.lowercased()
            let filtered = movieList.filter({ $0.title!.lowercased().contains(searchText) })
            if !filtered.isEmpty {
                self.filteredMovies = filtered
            }
           
            
          
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    }
}


