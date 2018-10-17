#if canImport(Foundation)
import Foundation

#if canImport(Cocoa)
import Cocoa

public final class PreferencesWindowController: NSWindowController {
    
    var tabViewController = PreferencesTabViewController()

    public init(viewControllers: [Preferenceable]) {
		precondition(!viewControllers.isEmpty, "You need to set at least one view controller")
        
        let window = NSWindow(
            contentRect: (viewControllers[0] as? NSViewController)?.view.bounds ?? .zero,
            styleMask: [
                .titled,
                .miniaturizable,
                .closable
            ],
            backing: .buffered,
            defer: true
        )
        
		super.init(window: window)

        window.title = String(System.localizedString(forKey: "Preferences…").dropLast())
        window.contentView = tabViewController.view
        
        tabViewController.tabViewItems = viewControllers.map { viewController in
            let item = NSTabViewItem(identifier: viewController.toolbarItemTitle)
            item.label = viewController.toolbarItemTitle
            item.image = viewController.toolbarItemIcon
            item.viewController = viewController as? NSViewController
            return item
        }
        
        tabViewController.tabStyle = .toolbar
        tabViewController.transitionOptions = [.crossfade, .slideDown]
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

    public override func showWindow(_ sender: Any?) {
        if let window = window, !window.isVisible {
            if !self.tabViewController.tabViewItems.isEmpty {
                if let rect = self.tabViewController.tabViewItems[0].viewController?.view.bounds {
                    window.setFrame(rect, display: true, animate: true)
                }
            }
            window.center()
        }
        
		super.showWindow(sender)
		NSApp.activate(ignoringOtherApps: true)
	}

	public func hideWindow() {
		close()
	}
    
    public func insert(viewController: Preferenceable, at index: Int) {
        tabViewController.insertTabViewItem(self.tabViewItem(with: viewController), at: index)
    }
    
    public func append(viewController: Preferenceable) {
        tabViewController.addTabViewItem(self.tabViewItem(with: viewController))
    }
    
    public func remove(viewController: Preferenceable) {
        self.tabViewController.removeTabViewItem(self.tabViewItem(with: viewController))
    }
    
    private func tabViewItem(with viewController: Preferenceable) -> NSTabViewItem {
        let item = NSTabViewItem(identifier: viewController.toolbarItemTitle)
        item.label = viewController.toolbarItemTitle
        item.image = viewController.toolbarItemIcon
        item.viewController = viewController as? NSViewController
        return item
    }
}

#endif

#endif
