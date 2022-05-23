import Foundation

struct BreedClassification {
    let probabilities: [(String, Double)]

    /// Sort classification by most probable to less probable breeds
    var sorted: BreedClassification {
        let sorted = probabilities.sorted { first, second in
            first.1 > second.1
        }
        return BreedClassification(probabilities: sorted)
    }

    func getValue(for breed: String) -> Double? {
        guard let breedValue = probabilities.first(where: { pair in pair.0 == breed }) else {
            return nil
        }
        return breedValue.1
    }

    func top(_ num: Int) -> BreedClassification? {
        guard num < probabilities.count else {
            return nil
        }

        return BreedClassification(probabilities: Array(probabilities[0 ..< num]))
    }

    // formatt ??
}
