import Cocoa
import Foundation

protocol DnDDelegate: class {
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool
}
