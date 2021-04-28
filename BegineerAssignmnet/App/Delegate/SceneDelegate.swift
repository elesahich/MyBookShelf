//
//  SceneDelegate.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private var appRouter: AppRouter?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    appRouter = AppRouter(
      appdependecies: AppDependencies(networkingService: NetworkingService()),
      navigationController: UINavigationController()
    )
    window = UIWindow(windowScene: scene)
    window?.rootViewController = appRouter?.navigationController
    appRouter?.start()
    window?.makeKeyAndVisible()
  }
}
