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
    private var cancellable = Set<AnyCancellable>()

    init() {
        setupBreedsListDataTaskPublisher()
    }

    private func setupBreedsListDataTaskPublisher() {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds?limit=400&page=0")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Dog].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { users in
                self.dogs = users
            })
            .store(in: &cancellable)
    }
}
