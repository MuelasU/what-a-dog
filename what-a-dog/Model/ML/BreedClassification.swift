import Foundation

/// Used as the result of breed classifier. This structure carries the probabilities for each breed and it has methods for manipulating it
struct BreedClassification {
    let probabilities: [(String, Double)]

    /// Sort classification by most probable to less probable breeds
    var sorted: BreedClassification {
        let sorted = probabilities.sorted { first, second in
            first.1 > second.1
        }
        return BreedClassification(probabilities: sorted)
    }

    /// Get the probability value for the breed request. Return `nil` if the breed wasn't found
    func getValue(for breed: String) -> Double? {
        // TODO: - Not tested
        guard let breedValue = probabilities.first(where: { pair in pair.0 == breed }) else {
            return nil
        }
        return breedValue.1
    }

    /// Get the top most probable breeds. Return `nil` if `num` is greater than the number of breeds in model
    func top(_ num: Int) -> BreedClassification? {
        guard num < probabilities.count else {
            return nil
        }

        return BreedClassification(probabilities: Array(sorted.probabilities[0 ..< num]))
    }

    /// Create an array of strings formatted as "Breed: Probability in percentage with specified `fractionDigits`"
    func formatted(fractionDigits: Int = 1) -> [String] {
        return probabilities.map { pair in
            let breed = pair.0
            let prob = pair.1.toPercentage(fractionDigits: fractionDigits)
            return "\(breed): \(prob)"
        }
    }
}
