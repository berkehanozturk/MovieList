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
    private var pageCount = 1
    var itemSize: NSCollectionLayoutSize!
    private let MovieResource: PopularMovieResource = PopularMovieResourceImpl()
    var movieList = [Movie]()
    var filteredMovies = [Movie]()
    var loadMoreView:  FooterCollectionReusableView?
    var selectedMovie: Movie?
 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
        customizeNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteMovies()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchPopularMovies()
    }

    ///setu  UIelements delegates  and register  UIelements
    private func setupUIElements() {
        collectionView.collectionViewLayout = setupCollectionViewLayout(isGrid: false)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        collectionView.register(MovieCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        registerForKeyboardNotifications(bottomConstraint: collectionViewbottomConstraint)
        searchBar.delegate = self
  
    }
    ///Customizing Navbar  and if navbars right item is clicked change the collection view layout
    private func customizeNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let rightButton  = MyBarButtonItem(buttonIconName: Assets.list.rawValue)
        rightButton.setNavbarButtonAction {
            if self.rightButtonTapped == true {
                rightButton.setButtonIcon(iconName: Assets.list.rawValue)
                self.rightButtonTapped.toggle()
                self.collectionView.collectionViewLayout = self.setupCollectionViewLayout(isGrid: false)
            }
            else{
                rightButton.setButtonIcon(iconName: Assets.table.rawValue)
                self.collectionView.collectionViewLayout = self.setupCollectionViewLayout(isGrid: true)
                self.rightButtonTapped.toggle()
            }
            
        }
        setupNavBar(right: rightButton)
      
    }
    /// Setup  CollectionViewLayout   with parameter  isGrid bool variable
    private func setupCollectionViewLayout(isGrid: Bool) -> UICollectionViewCompositionalLayout {
      let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in

        var itemCount = 1
        if isGrid == true { // this controls appearance of collectionView
            
            itemCount = 2
        }
        
        self.itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)          )
        var item = NSCollectionLayoutItem(layoutSize: self.itemSize)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400)
        )
        
        if environment.container.contentSize.width > 700 { // if screen width is greater than 700 user rotated to the land scape mod
            if isGrid == false { //  landscape mod is turned and grid look is false  change the item size
                self.itemSize = NSCollectionLayoutSize (
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.8)
                )
                item = NSCollectionLayoutItem(layoutSize: self.itemSize)
            }
        }else {
            item = NSCollectionLayoutItem(layoutSize: self.itemSize)
            
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
    //passing SelectedMovie to Detail Page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDetailVc.rawValue{
            if let detailVc = segue.destination as? DetailViewController {
                detailVc.selectedMovie = selectedMovie
                  }
        }
    }
 
  ///this  function increment page count and fetchPopular movies again
    @objc func loadMore(){
        pageCount = pageCount+1
        fetchPopularMovies()
    }
    ///This function get movies array and  check that movie array's atleast one element is in movieList  if it containt return true   if not return false
    func isContainsSameElement(movies: [Movie]) -> Bool {
        for movie in movies {
           let contains =  self.movieList.contains(movie)
            if contains == true {
                return true
            }
        }
        return false
    }
    ///fetchin popular movies  with pageCount
    private func fetchPopularMovies() {
        MovieResource.getPopularMovies(page: pageCount) { (dataResponse) in
            switch dataResponse {
            case .success(let movieResults):
                guard let movies  = movieResults.results else{return}
                if  !self.isContainsSameElement(movies: movies) {
                    self.movieList.append(contentsOf: movies)
                    self.filteredMovies = self.movieList
                
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert(message: "Somethink went wrong!")
                }
                
                
            }
        }
    }
    //fetching favourites movie from UserDefaults
    private func fetchFavoriteMovies() {
        if let persistedMovies = GlobalVariables.favouriteMovies.fetchFavourites() {
            GlobalVariables.favouriteMovies = persistedMovies
        }
    }
    
}

//MARK:  collection View Delegate Functions
extension MovieListViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :MovieCell = collectionView.dequeueReusableCell(for: indexPath)
        filteredMovies[indexPath.item].isFavourite =  filteredMovies[indexPath.item].isFavouriteMovie()
        cell.movie = filteredMovies[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = filteredMovies[indexPath.item]
        self.performSegue(withIdentifier: Segues.toDetailVc.rawValue, sender: nil)
    }
 
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        loadMoreView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as? FooterCollectionReusableView
        loadMoreView?.delegate = self
                return loadMoreView!
 
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
}

//MARK: Search bar Delegate Functions
extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadMoreView?.isHidden = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil) // if user writes to fast cancel the PreviousPerformRequests
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
            loadMoreView!.isHidden = false
        }
        else {
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


extension MovieListViewController: HideHeaderViewDelegate {
    func hideHeaderView() {
        loadMore()
    }
}
