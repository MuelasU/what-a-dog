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
        apiService.retrieveDogsData(completion: { [self] dogs in
            self.dogs = dogs
            self.filterDogs(toBeFiltered: &self.dogs, theFilter: BreedsListEnum.allCases.map { $0.rawValue })
        })
    }

    func filterDogs(toBeFiltered: inout [Dog], theFilter: [String]) {
        toBeFiltered = toBeFiltered.filter { dog -> Bool in
            theFilter.contains(dog.name)
        }
    }
}
