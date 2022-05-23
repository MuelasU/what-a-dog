import Vision

/// Handle the classification model for dog breeds
class BreedDetector {
    private let classifier: BreedClassifier

    private let inputSize = CGSize(width: 224, height: 224)

    init() throws {
        let configuration = MLModelConfiguration()
        configuration.computeUnits = .all
        classifier = try BreedClassifier(configuration: configuration)
    }
    
    /// Apply the classification algorithm for the requested `image`. Returns the result as a ``BreedClassification`` structure
    func classify(image: CGImage) throws -> BreedClassification {
        guard let buffer = image.toPixelBuffer(size: inputSize) else {
            throw MLModelError(.io)
        }
        let output = try classifier.prediction(dogImage: buffer)
        return BreedClassification(probabilities: Array(output.probabilities))
    }
}
