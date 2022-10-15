//
//  AppDelegate.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 12/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: CoordinatorProtocol!
    
    func application(
        _: UIApplication,
        willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
//        if let animationStub = ProcessInfo.processInfo.decode(AnimationStub.self) {
//            UIView.setAnimationsEnabled(animationStub.areAnimationsEnabled)
//        }

//        let session: URLSessionProtocol = ProcessInfo.processInfo.decode(URLSessionMock.self) ?? URLSession(configuration: .default)
//        let networkManager = NetworkManager()
////        let networkManager = NetworkManager(session: session)
//        let factory = DependencyManager(networkManager: networkManager)
//        let window = UIWindow(frame: UIScreen.main.bounds)
//
//        coordinator = Coordinator(factory: factory, window: window)

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        coordinator.start()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

