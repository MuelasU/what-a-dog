//
//  DogsApiService.swift
//  what-a-dog
//
//  Created by Eduardo Dini on 23/05/22.
//

import Combine
import Foundation

class DogApiService {
    let url = URL(string: "https://api.thedogapi.com/v1/breeds?limit=400&page=0")!
    let decoder = JSONDecoder()
    private var cancellable = Set<AnyCancellable>()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func setupBreedsListDataTaskPublisher(completion: @escaping ([Dog]) -> Void) {
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
            .sink(receiveCompletion: { _ in }, receiveValue: { dogs in
                completion(dogs)
            })
            .store(in: &cancellable)
    }
}
