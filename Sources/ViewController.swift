import Cocoa
import AVFoundation

final class ViewController: NSViewController {
    @IBOutlet private weak var containerView: NSView!

    private var currentController: NSViewController? = nil {
        didSet {
            if let oldValue: NSViewController = oldValue {
                oldValue.removeFromParentViewController()
                oldValue.view.removeFromSuperview()
            }
            if let currentController: NSViewController = currentController {
                containerView.addSubview(currentController.view)
                currentController.view.translatesAutoresizingMaskIntoConstraints = false
                let constraints: [NSLayoutConstraint] = [.top, .bottom, .leading, .trailing].map { (attr: NSLayoutConstraint.Attribute) in
                    return NSLayoutConstraint(
                        item: currentController.view,
                        attribute: attr,
                        relatedBy: .equal,
                        toItem: containerView,
                        attribute: attr,
                        multiplier: 1,
                        constant: 0
                    )
                }
                containerView.addConstraints(constraints)
                addChildViewController(currentController)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentController = FLVAnalyzerViewController.getUIViewController()
    }

    @IBAction func didSegmentChanged(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            currentController = FLVAnalyzerViewController.getUIViewController()
        case 1:
            currentController = RTMPAnalyzerViewController.getUIViewController()
        default:
            break
        }
    }
}
