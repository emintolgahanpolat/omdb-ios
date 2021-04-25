//
//  HomeViewModel.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 23.04.2021.
//

import Foundation
import Alamofire

class HomeViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    var movieList : Observable<[Movie]> = Observable([])
   
    func fetchData(_ keyword:String){
        if (keyword.isEmpty) {return}
        isLoading.value = true
        ApiClient.instance.request(Constants.API.baseURL,method: .get,parameters: [
            "apikey":Constants.API.key,
            "s":keyword
        ]).responseDecodable(completionHandler: {
            (response: AFDataResponse<MovieSearchData>) in
            self.isLoading.value = false
            do {
                
                self.movieList.value?.append(contentsOf: try (response.result.get().search ?? []))
                
            } catch {
                print(error)
            }
        })
        
        
    }
}


