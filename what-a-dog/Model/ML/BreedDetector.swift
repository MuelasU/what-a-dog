import Vision

class BreedDetector {
    private let classifier: BreedClassifier

    init?() {
        let configuration = MLModelConfiguration()
        configuration.computeUnits = .all
        do {
            classifier = try BreedClassifier(configuration: configuration)
        } catch {
            return nil
        }
    }

    func classify(image: CGImage) throws -> BreedClassification {
        guard
            let image = image.toPixelBuffer(),
            let output = try? classifier.prediction(dogImage: image)
        else {
            throw MLModelError(.generic)
        }

        return BreedClassification(probabilities: output.probabilities)
    }
}
