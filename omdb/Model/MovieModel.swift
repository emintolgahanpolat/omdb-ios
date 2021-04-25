//
//  MovieModel.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 23.04.2021.
//

import Foundation

// MARK: - MovieData
struct MovieSearchData: Codable {
    let search: [Movie]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Movie: Codable {
    let rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes: String?
    let dvd, boxOffice, production: String?
    let website, response: String?
    
    
    let title, year, imdbID: String?
    let type: VideoType?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

struct Rating: Codable {
    let source, value: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}


enum VideoType: String, Codable ,CaseIterable{
    case movie = "movie"
    case series = "series"
    case episode = "episode"
}
extension VideoType{
    static var allValue: [String] {
        get{
            return VideoType.allCases.map{ i in
                i.rawValue.capitalized
            }
        }
    }
}
