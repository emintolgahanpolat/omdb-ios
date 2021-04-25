//
//  ViewController.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 23.04.2021.
//

import UIKit

class HomeViewController: ETPViewController {
    
    
    private lazy var refreshControl : UIRefreshControl={
        let mRefreshControl = UIRefreshControl()
        mRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return mRefreshControl
        
    }()
    
    private lazy var collectionView:UICollectionView = {
        let mCollectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: UICollectionViewFlowLayout())
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
        mCollectionView.backgroundColor = .systemBackground
        mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        mCollectionView.alwaysBounceVertical = true
        mCollectionView.addSubview(refreshControl)
        return mCollectionView
    }()
    
    lazy var searchViewContrroller:SearchViewController={
        var mSearchViewContrroller = SearchViewController()
        mSearchViewContrroller.mNavigationController = navigationController
        return mSearchViewContrroller
    }()
    
    private lazy var searchController :UISearchController = {
        let mSearchController = UISearchController(searchResultsController: searchViewContrroller)
        
        mSearchController.searchResultsUpdater = self
        mSearchController.obscuresBackgroundDuringPresentation = false
        mSearchController.searchBar.enablesReturnKeyAutomatically = false
        mSearchController.searchBar.returnKeyType = UIReturnKeyType.done
        mSearchController.searchBar.placeholder = "Film Ara"
        mSearchController.searchBar.sizeToFit()
        mSearchController.searchBar.delegate = self
        mSearchController.searchBar.scopeButtonTitles = VideoType.allValue
        definesPresentationContext = true
        return mSearchController
    }()
    
    @objc func refresh(){
        viewModel.movieList.value?.removeAll()
        viewModel.fetchData("star")
    }
    lazy var viewModel : HomeViewModel = {
        return HomeViewModel()
    }()
    
    
    private func setupUI(){
        title = "loodos"
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        viewModel.isLoading.bind{ isLoading in
            if isLoading.value == true {
                ETPLoading.sharedInstance.show()
            }else {
                ETPLoading.sharedInstance.hide()
            }
        }
        
        viewModel.movieList.bind{ i in
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewModel.fetchData("star")
    }
    
}
extension HomeViewController: UISearchResultsUpdating ,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        (self.searchController.searchResultsController as! SearchViewController).searchQuery = searchController.searchBar.text ?? ""
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        (self.searchController.searchResultsController as! SearchViewController).scope = VideoType.allValue[selectedScope]
    }
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieList.value?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if(indexPath.row == 0){
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width * (4/3))
        }
        
        if(indexPath.row == 7){
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width )
        }
        let width = (self.collectionView.frame.width - 10) / 2
        return CGSize(width: width, height: width * (4/3))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MovieCollectionViewCell
        let item = viewModel.movieList.value![indexPath.row]
        cell.posterImageView.loadImage(item.poster)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.imdbID = viewModel.movieList.value![indexPath.row].imdbID!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let detailAction = UIAction(title: "Detay",image: nil) { action in }
            let addFavoriteAction = UIAction(title: "Favorilere Ekle",image: nil) { action in }
            return UIMenu(title: "", children: [detailAction, addFavoriteAction])
        }
    }
    
    
}
