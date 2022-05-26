import CoreMotion
import UIKit

/// Handle data from accelerometer. Use the `shared` instance for accessing its properties
class AccelerometerService {
    // Singleton
    static let shared: AccelerometerService = .init()

    // MARK: - Interface

    private(set) var orientation: UIDeviceOrientation?

    func start() {
        manager.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler: { data, error in
            if let error = error {
                print("Error on accelerometer update", error.localizedDescription)
            }
            if let data = data {
                self.updateOrientation(with: data.acceleration)
            }
        })
    }

    func stop() {
        manager.stopAccelerometerUpdates()
    }

    // MARK: - Model

    private let manager: CMMotionManager
    private let updatePeriod: TimeInterval = 0.5

    private init() {
        manager = CMMotionManager()
        manager.accelerometerUpdateInterval = updatePeriod
        manager.gyroUpdateInterval = updatePeriod
    }

    private func updateOrientation(with acceleration: CMAcceleration) {
        var newOrientation: UIDeviceOrientation
        if acceleration.x >= 0.75 {
            newOrientation = .landscapeRight
        } else if acceleration.x <= -0.75 {
            newOrientation = .landscapeLeft
        } else if acceleration.y >= 0.75 {
            newOrientation = .portraitUpsideDown
        } else if acceleration.y <= -0.75 {
            newOrientation = .portrait
        } else {
            return
        }
        orientation = newOrientation
    }
}
