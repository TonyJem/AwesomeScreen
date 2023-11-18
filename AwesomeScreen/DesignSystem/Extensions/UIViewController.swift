import UIKit

extension UIViewController {

    open class LightStatusBar: UIViewController {

        public override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }

        open override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            // Needed beacuase in iOS 15,
            // when reading the status bar `preferredStatusBarStyle`
            // is performed at the wrong time and gets wrong color
            setNeedsStatusBarAppearanceUpdate()
        }

    }

}
