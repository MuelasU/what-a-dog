//
//  BreedListViewModel.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 18/05/22.
//

import Combine
import Foundation

class BreedListViewModel: ObservableObject {
    @Published var time = ""
    @Published var dogs = [Dog]()
    private var apiService: DogApiService!

    init() {
        apiService = DogApiService()
        callFuncToGetDogsData()
    }

    func callFuncToGetDogsData() {
        apiService.setupBreedsListDataTaskPublisher(completion: { dogs in
            self.dogs = dogs
        })
    }
}
