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
    var itemSize: NSCollectionLayoutSize!
    private let MovieResource: PopularMovieResource = PopularMovieResourceImpl()
    var movieList = [Movie]()
    var filteredMovies = [Movie]()
    var loadMoreButton = UIButton()
    var selectedMovie: Movie?
    var hideFooter: Bool = true //or false to not hide the header
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchPopularMovies()
        setupUIElements()
        customizeNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteMovies()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }

    private func setupUIElements() {
        searchBar.delegate = self
        registerForKeyboardNotifications(bottomConstraint: collectionViewbottomConstraint)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupLayout(isGrid: false)
    }
    
    private func setupLayout(isGrid: Bool) -> UICollectionViewCompositionalLayout {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toDetailVc.rawValue{
            if let detailVc = segue.destination as? DetailViewController {
                detailVc.selectedMovie = selectedMovie
                  }
        }
    }
 
    private func customizeNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let rightButton  = MyBarButtonItem(buttonIconName: Assets.list.rawValue)
        rightButton.setNavbarButtonAction {
            if self.rightButtonTapped == true {
                rightButton.setButtonIcon(iconName: Assets.list.rawValue)
                self.rightButtonTapped.toggle()
                self.collectionView.collectionViewLayout = self.setupLayout(isGrid: false)
            }
            else{
                rightButton.setButtonIcon(iconName: Assets.table.rawValue)
                self.collectionView.collectionViewLayout = self.setupLayout(isGrid: true)
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
                self.movieList.append(contentsOf: movieResults.results!)
                self.filteredMovies = self.movieList
                    DispatchQueue.main.async {
                            self.collectionView.reloadData()
                    }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert(message: "Somethink went wrong!")
                }
                
                
            }
        }
    }
    private func fetchFavoriteMovies() {
        if let persistedMovies = GlobalVariables.favouriteMovies.fetchFavourites() {
            GlobalVariables.favouriteMovies = persistedMovies
        }
    }
    
}
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
        if kind ==  UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath)
            for views in footer.subviews  where views is UIButton{
                loadMoreButton = views as! UIButton
                loadMoreButton.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
                if filteredMovies.count < 20 {
                    loadMoreButton.isHidden = true
                }else{
                    loadMoreButton.isHidden = false

                }
            }
            return footer
        }
        return UICollectionReusableView()
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 50, height: 50)
    }
    
    
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
        loadMoreButton.isHidden = true
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


