//
//  List.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movies : Mappable {
    var results : [Results]?
    var page : Int?
    var total_results : Int?
    var dates : Dates?
    var total_pages : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        results <- map["results"]
        page <- map["page"]
        total_results <- map["total_results"]
        dates <- map["dates"]
        total_pages <- map["total_pages"]
    }

}

struct Results : Mappable {
    var popularity : Double?
    var vote_count : Int?
    var video : Bool?
    var poster_path : String?
    var id : Int?
    var adult : Bool?
    var backdrop_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int]?
    var title : String?
    var vote_average : Double?
    var overview : String?
    var release_date : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        popularity <- map["popularity"]
        vote_count <- map["vote_count"]
        video <- map["video"]
        poster_path <- map["poster_path"]
        id <- map["id"]
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        genre_ids <- map["genre_ids"]
        title <- map["title"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        release_date <- map["release_date"]
    }

}

struct Dates : Mappable {
    var maximum : String?
    var minimum : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        maximum <- map["maximum"]
        minimum <- map["minimum"]
    }

}
