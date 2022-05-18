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
    @Published var users = [Dog]()
    private var cancellable = Set<AnyCancellable>()

    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()

    init() {
        setupPublisher()
    }

    private func setupPublisher() {
        setupTimePublisher()
        setupDataTaskPublisher()
    }

    private func setupTimePublisher() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancellable)
    }

    private func setupDataTaskPublisher() {
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
                self.users = users
            })
            .store(in: &cancellable)
    }
}
