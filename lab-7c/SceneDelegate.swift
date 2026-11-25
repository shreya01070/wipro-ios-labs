import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let homeScreen = ViewController()

        let navigationController = UINavigationController(
            rootViewController: homeScreen
        )

        let appWindow = UIWindow(windowScene: windowScene)

        appWindow.rootViewController = navigationController

        window = appWindow
        appWindow.makeKeyAndVisible()
    }
}
