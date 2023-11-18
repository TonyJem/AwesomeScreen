import UIKit

// TODO: Need to delete this file, while is not needed
// Test View Controller - can be used for implementation tests
class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        view.backgroundColor = .green

        title = "Control Units"

    }

}
