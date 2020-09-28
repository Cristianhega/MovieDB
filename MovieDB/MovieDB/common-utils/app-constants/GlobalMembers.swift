//
//  GlobalMembers.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import Foundation

struct Constants {
        
    static var baseUrl = "https://api.themoviedb.org/3"
    static var apiKey = "634b49e294bd1ff87914e7b9d014daed"
    static var urlImages = "https://image.tmdb.org/t/p/w500"
    static var urlBanner = "https://image.tmdb.org/t/p/original"
}


enum Urls:String{
    case NOW_PLAYING = "/movie/now_playing"
    case MOVIE_DETAILS = "/movie"
    case IMAGES = "https://image.tmdb.org/t/p/w500"
}



