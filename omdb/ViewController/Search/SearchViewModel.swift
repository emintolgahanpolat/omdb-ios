//
//  SearchViewModel.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import Foundation
import Alamofire

class SearchViewModel{
    var pageCount:Int = 1
    var movieList : Observable<[Movie]> = Observable([])
    private var isLoading = false
    
     func fetchData(_ keyword:String,scope:String){
        if (keyword.isEmpty) {return}
        if(isLoading) {return}
        isLoading = true
        ApiClient.instance.request(Constants.API.baseURL,method: .get,parameters: [
            "apikey":Constants.API.key,
            "s":keyword,
            "page":pageCount,
            "type":scope.lowercased()
        ]).responseDecodable(completionHandler: {
            (response: AFDataResponse<MovieSearchData>) in
            self.isLoading = false
            do {
                self.pageCount += 1
                self.movieList.value?.append(contentsOf: try (response.result.get().search ?? []))

            } catch {
                print(error)
            }
        })
        
        
    }
}


