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

    private func checkForDog(in image: CGImage) -> Bool {
        var hasDog = false
        let dogRecognitionRequest = VNRecognizeAnimalsRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                print("No results found for recognize animal request")
                return
            }

            for result in results {
                let animals = result.labels
                for animal in animals where animal.identifier == "Dog" {
                    hasDog = true
                }
            }
        }

        let requestHandler = VNImageRequestHandler(cgImage: image)
        do {
            try requestHandler.perform([dogRecognitionRequest])
        } catch {
            print("Error on dog recognition request")
        }
        return hasDog
    }

    /// Apply the classification algorithm for the requested `image`. Returns the result as a ``BreedClassification`` structure
    func classify(image: CGImage) throws -> BreedClassification? {
        guard checkForDog(in: image) else {
            return nil
        }

        guard let buffer = image.toPixelBuffer(size: inputSize) else {
            throw MLModelError(.io)
        }

        let output = try classifier.prediction(dogImage: buffer)
        return BreedClassification(probabilities: Array(output.probabilities))
    }
}
