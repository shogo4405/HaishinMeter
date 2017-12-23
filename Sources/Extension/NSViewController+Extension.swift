import Foundation
import Cocoa

extension NSViewController {
    class var identifier: NSStoryboard.SceneIdentifier {
        return NSStoryboard.SceneIdentifier(className)
    }

    class func getUIViewController() -> NSViewController {
        let storyboard: NSStoryboard = NSStoryboard(name: .main, bundle: Bundle.main)
        return storyboard.instantiateController(withIdentifier: identifier) as! NSViewController
    }
}
