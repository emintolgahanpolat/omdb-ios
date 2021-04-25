//
//  SearchViewController.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import UIKit

class SearchViewController: ETPViewController {
    
    var mNavigationController :UINavigationController? = nil
    lazy var viewModel: SearchViewModel =  SearchViewModel()
    var searchQuery : String = "" {
        didSet{
            viewModel.pageCount = 1
            viewModel.movieList.value?.removeAll()
            viewModel.fetchData(searchQuery,scope:scope)
        }
    }
    var scope : String = VideoType.movie.rawValue.lowercased() {
        didSet{
            viewModel.pageCount = 1
            viewModel.movieList.value?.removeAll()
            viewModel.fetchData(searchQuery,scope:scope)
        }
    }
    
    lazy var emptyInfo :UILabel={
       var mView = UILabel()
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.text = "Sonuç bulunamadı.."
        mView.textAlignment = .center
        mView.font = .systemFont(ofSize: 24, weight: .bold)
        return mView
    }()
    
    private lazy var tableView:UITableView = {
        let mTableView = UITableView()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.rowHeight = 300
        mTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MyCell")
        mTableView.translatesAutoresizingMaskIntoConstraints = false
        
        return mTableView
    }()
    
    private func setupUI(){
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        
        view.addSubview(emptyInfo)
        emptyInfo.isHidden = true
        emptyInfo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        emptyInfo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        emptyInfo.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
       
        
        viewModel.movieList.bind{ i in
            self.tableView.reloadData()
            if(i.value?.count == 0){
                self.emptyInfo.isHidden = false
            }else{
                self.emptyInfo.isHidden = true
            }
        }
    }
    
}


extension SearchViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MovieTableViewCell
        
        let item = viewModel.movieList.value![indexPath.row]
        
        cell.poster.loadImage(item.poster)
        cell.poster.contentMode = .scaleAspectFit
        cell.title.text = item.title
        cell.year.text = item.year
        cell.type.text = item.type?.rawValue.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.imdbID = viewModel.movieList.value![indexPath.row].imdbID!
        mNavigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = CGFloat(offset.y + bounds.size.height - inset.bottom)
        let h = CGFloat(size.height)
        
        let reload_distance = CGFloat(10)
        if(y > (h + reload_distance)) {
            viewModel.fetchData(searchQuery,scope: scope)
        }
    }
}


