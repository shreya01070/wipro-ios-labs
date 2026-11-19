import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        print("Scene: Connected")

        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: windowScene)

        let firstScreen = ViewController()
        let navigation = UINavigationController(
            rootViewController: firstScreen
        )

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Scene: Will resign active")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Scene: Entered background")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Scene: Will enter foreground")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Scene: Became active")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("Scene: Disconnected")
    }
}
