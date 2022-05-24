import Foundation

extension Double {
    func toPercentage(fractionDigits: Int) -> String {
        let value = self * 100
        return String(format: "%.\(fractionDigits)f%%", value)
    }
}
