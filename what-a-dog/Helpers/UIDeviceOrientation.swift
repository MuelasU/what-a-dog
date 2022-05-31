import AVFoundation
import UIKit

extension UIDeviceOrientation {
    var toRotatedUIImageOrientation: UIImage.Orientation {
        switch self {
        case .portrait, .faceUp:
            return .right
        case .portraitUpsideDown, .faceDown:
            return .left
        case .landscapeLeft:
            return .up
        case .landscapeRight:
            return .down
        default:
            return .right
        }
    }
}
