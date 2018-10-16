#if canImport(Foundation)
import Foundation

#if canImport(Cocoa)
import Cocoa

public protocol Preferenceable: AnyObject {
	var toolbarItemTitle: String { get }
	var toolbarItemIcon: NSImage { get }
}

extension Preferenceable where Self: Equatable {
    /// Returns a Boolean value indicating whether two `Coordinator` are equal.
    ///
    /// Equality is the inverse of inequality. For any values `lhs` and `rhs`,
    /// `lhs == rhs` implies that `lhs != rhs` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.toolbarItemTitle == rhs.toolbarItemTitle && lhs.toolbarItemIcon == rhs.toolbarItemIcon
    }
}

#endif

#endif
