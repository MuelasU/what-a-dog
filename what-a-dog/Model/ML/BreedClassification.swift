import Foundation

struct BreedClassification {
    let probabilities : [String : Double]
    
    /// Sort classification by most probable to less probable breeds
    func sorted() -> BreedClassification {
        let sorted = probabilities.sorted {
            $0.value > $1.value
        }.reduce(into: [:]) {
            $0[$1.key] = $1.value
        }
        
        return BreedClassification(probabilities: sorted)
    }
        
    func getValue(for breed: String) -> Double? {
        return probabilities[breed]
    }
    
    func slice(to first: Int, from last: Int) -> BreedClassification? {
        let keyValues = Array(probabilities)
        
        guard
            first >= keyValues.startIndex,
            last <= keyValues.endIndex
        else {
            return nil
        }
                
        let sliced = keyValues[first ..< last].reduce(into: [:]) {
            $0[$1.key] = $1.value
        }
        return BreedClassification(probabilities: sliced)
    }
    
    //formatt ??
}
