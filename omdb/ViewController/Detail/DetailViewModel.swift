//
//  DetailViewModel.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 25.04.2021.
//

import Foundation
import Alamofire
import Firebase

class DetailViewModel{
    
    var movie : Observable<Movie> = Observable(nil)
    var isLoading : Observable<Bool> = Observable(false)
    
    func fetchData(_ imdbID:String){
        
        isLoading.value = true
        ApiClient.instance.request(Constants.API.baseURL,method: .get,parameters: [
            "apikey":Constants.API.key,
            "i":imdbID
        ]).responseDecodable(completionHandler: {
            (response: AFDataResponse<Movie>) in
            self.isLoading.value = false
            do {
                
                self.movie.value = try (response.result.get())
                Analytics.logEvent("movie_detail_open", parameters: [
                                    "imdbID":imdbID])
                
            } catch {
                print(error)
            }
        })
        
        
    }
}


