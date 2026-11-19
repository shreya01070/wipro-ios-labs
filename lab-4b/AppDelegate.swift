import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        print("App: Application launched")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("App: Will become inactive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App: Entered background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App: Will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App: Became active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("App: Application will terminate")
    }

    // Connecting the scene with the application
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
