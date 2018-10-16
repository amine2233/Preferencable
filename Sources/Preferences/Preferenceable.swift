#if canImport(Foundation)
import Foundation

#if canImport(Cocoa)
import Cocoa

public protocol Preferenceable: AnyObject {
	var toolbarItemTitle: String { get }
	var toolbarItemIcon: NSImage { get }
}

#endif

#endif
