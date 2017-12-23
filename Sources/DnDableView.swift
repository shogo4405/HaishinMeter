import Cocoa
import Foundation

final class DnDableView: NSView {
    weak var delegate: DnDDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let draggedType = NSPasteboard.PasteboardType(kUTTypeURL as String)
        registerForDraggedTypes([draggedType])
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        guard let delegate: DnDDelegate = delegate else {
            return super.draggingEntered(sender)
        }
        return delegate.draggingEntered(sender)
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let delegate: DnDDelegate = delegate else {
            return super.performDragOperation(sender)
        }
        return delegate.performDragOperation(sender)
    }
}
