//
//  BreedListViewModel.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import Combine
import Foundation

class BreedListViewModel: ObservableObject {
    @Published var dogs = [Dog]()
    private var apiService: DogApiService!

    init() {
        apiService = DogApiService()
        getDogsData()
    }

    func getDogsData() {
        apiService.retrieveDogsData(completion: { dogs in
            self.dogs = dogs
        })
    }
}
