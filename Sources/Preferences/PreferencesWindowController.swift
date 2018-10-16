#if canImport(Foundation)
import Foundation

#if canImport(Cocoa)
import Cocoa

public final class PreferencesWindowController: NSWindowController {
	private let tabViewController = PreferencesTabViewController()
    
    var controllers: [Preferenceable]

	public init(viewControllers: [Preferenceable]) {
		//precondition(!viewControllers.isEmpty, "You need to set at least one view controller")
        self.controllers = viewControllers
        
		let window = NSWindow(
			contentRect: (viewControllers[0] as! NSViewController).view.bounds,
			styleMask: [
				.titled,
				.closable
			],
			backing: .buffered,
			defer: true
		)
		super.init(window: window)

		window.title = String(System.localizedString(forKey: "Preferences…").dropLast())
		window.contentView = tabViewController.view

		tabViewController.tabViewItems = self.controllers.map { viewController in
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
        self.controllers = []
		super.init(coder: coder)
	}

	public func showWindow() {
		if !window!.isVisible {
			window?.center()
		}

		showWindow(self)
		NSApp.activate(ignoringOtherApps: true)
	}

	public func hideWindow() {
		close()
	}
    
    public func insert(viewController: Preferenceable, at: Int) {
        self.controllers.insert(viewController, at: at)
        let item = NSTabViewItem(identifier: viewController.toolbarItemTitle)
        item.label = viewController.toolbarItemTitle
        item.image = viewController.toolbarItemIcon
        item.viewController = viewController as? NSViewController
        tabViewController.tabViewItems.insert(item, at: at)
    }
    
    public func append(viewController: Preferenceable) {
        self.controllers.append(viewController)
        let item = NSTabViewItem(identifier: viewController.toolbarItemTitle)
        item.label = viewController.toolbarItemTitle
        item.image = viewController.toolbarItemIcon
        item.viewController = viewController as? NSViewController
        tabViewController.tabViewItems.append(item)
    }
    
    public func remove(viewController: Preferenceable) {
        self.tabViewController.tabViewItems = self.tabViewController.tabViewItems.filter { $0 !== viewController }
        self.controllers = self.controllers.filter { $0 !== viewController }
    }
}

#endif

#endif
