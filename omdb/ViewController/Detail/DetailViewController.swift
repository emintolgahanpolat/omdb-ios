//
//  DetailViewController.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 25.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var about: UILabel!
    
    var imdbID:String? = nil
    lazy var viewModel :DetailViewModel = {
        return DetailViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.movie.bind{i in
            self.poster.loadImage(i.value?.poster)
            self.movieTitle.text = i.value?.title
            self.rating.text = i.value?.imdbRating
            self.metascore.text = i.value?.ratings?.last?.value
            self.about.text = i.value?.plot
            
            
        }
        viewModel.isLoading.bind{ isLoading in
            if isLoading.value == true {
                ETPLoading.sharedInstance.show()
            }else {
                ETPLoading.sharedInstance.hide()
            }
        }
        if(imdbID != nil){
            viewModel.fetchData(imdbID!)
        }else{
            showAlert(title: "Hata", message: "Bir sorun oluştu", actions: [
                UIAlertAction(title: "Tamam", style: .default, handler: { i in
                    self.navigationController?.popViewController(animated: true)
                })
            ])
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
