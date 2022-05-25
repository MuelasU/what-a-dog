//
//  Dog.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import Foundation

struct Dog: Decodable, Identifiable {
    var weight: DogWeight?
    var height: DogHeight?
    var id: Int
    var name: String
    var bredFor: String?
    var breedGroup: String?
    var lifeSpan: String?
    var temperament: String?
    var image: DogImage?
}
