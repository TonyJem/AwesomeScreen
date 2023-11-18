import UIKit

// TODO: Need to sort all folders in project in ABC
// TODO: Might it would be relevant to deveide DesignSystem into separate Module
// TODO: Check if all clases that should be final are final ?
// TODO: Clean SwiftLint errors or redifine rules
// TODO: We can look at design System and ring all needd colors and elements that are needed
// TODO: Probably all emtyScreens we can bring into one an set all needed Viewstates for it

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // TODO: Need to create main coordinator
    // and from that coordinator need to create VIPER module
    // Think where it should be puted!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()

        let presenter = ControlUnits.Presenter()

        let viewController = ControlUnits.ViewController(with: presenter)

        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
