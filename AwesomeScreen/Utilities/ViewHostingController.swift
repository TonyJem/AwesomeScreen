import SwiftUI
import UIKit

/// `SwiftUI` wrapper class.
public final class ViewHostingController<T: View> {

    private let hostingController: UIHostingController<T>

    /// ViewController hosting the SwiftUI view inside.
    /// When embedding into another UIViewController,
    /// remember to add it as a child.
    public var viewController: UIViewController { hostingController }

    /// View hosted in the SwiftUI's HostingController.
    public var view: UIView { hostingController.view }

    public init(_ rootView: T) {
        self.hostingController = UIHostingController(rootView: rootView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .Branded.backgroundDark
    }

    // MARK: - Public

    /// Adds the `SwiftUIView` to any `UIView`.
    public func add(to parentView: UIView, useSafeArea: Bool = false) {
        parentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        if useSafeArea {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
                view.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
                view.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                view.topAnchor.constraint(equalTo: parentView.topAnchor),
                view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
            ])
        }

    }

}
