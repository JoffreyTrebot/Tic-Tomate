import UIKit

class OrientationService {
    static let shared = OrientationService()
    
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    
    func lockToPortrait() {
        lockOrientation(.portrait)
    }
    
    func lockToLandscapeLeft() {
        lockOrientation(.landscapeLeft)
    }
} 