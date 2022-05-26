import AVFoundation
import UIKit

extension UIDeviceOrientation {
//    var toAVCaptureVideoOrientation: AVCaptureVideoOrientation {
//        switch self {
//        case .portrait:
//            return AVCaptureVideoOrientation.portrait
//        case .portraitUpsideDown:
//            return AVCaptureVideoOrientation.portraitUpsideDown
//        case .landscapeLeft:
//            return AVCaptureVideoOrientation.landscapeRight
//        case .landscapeRight:
//            return AVCaptureVideoOrientation.landscapeLeft
//        default:
//            print(self)
//            return AVCaptureVideoOrientation.portrait
//        }
//    }

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
