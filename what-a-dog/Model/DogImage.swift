//
//  DogImage.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import Foundation

struct DogImage: Decodable, Identifiable {

    var id: String
    var width: Int
    var height: Int
    var url: String
    
}
