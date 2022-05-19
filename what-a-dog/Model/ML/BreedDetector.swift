import Vision

class BreedDetector {
    private let classifier : BreedClassifier
    
    init() {
        let configuration = MLModelConfiguration()
        configuration.computeUnits = .all
        classifier = try! BreedClassifier(configuration: configuration)
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
