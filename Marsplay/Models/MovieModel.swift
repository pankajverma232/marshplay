//
//  MovieModel.swift
//  Marsplay
//
//  Created by Pankaj Verma on 05/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
import UIKit

struct Root : Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case count = "totalResults" , response = "Response"
        case search = "Search"
    }
    
    let count : String?
    let response : String?
    let search : [MovieModel]?
}


struct MovieModel:Decodable {
    let posterImageUrl: String?
    let title: String?
    let type:String?
    let year:String?
    let id:String?
    private enum CodingKeys: String, CodingKey {
        case posterImageUrl = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
        case id = "imdbID"
    }
    
}
