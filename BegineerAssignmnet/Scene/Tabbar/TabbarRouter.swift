//
//  TabbarRouter.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/21.
//

import UIKit

enum TabbarChildRouter: Int {
  case new
  case search
}

final class TabbarRouter: NavigationRouterType {
  let navigationController: UINavigationController
  private let tabbarDependencies: TabbarDependencies
  private var tabbarController: UITabBarController?
  private var childRouters: [TabbarChildRouter: NavigationRouterType]
  
  init(
    navigationController: UINavigationController,
    dependencies: TabbarDependencies
  ) {
    self.navigationController = navigationController
    self.tabbarDependencies = dependencies
    self.childRouters = [:]
  }
}

extension TabbarRouter {
  func start() {
    setupNewViewRouter()
    setupSearchViewRouter()
    
    setupTabbarController()
  }
  
  private func store(with router: NavigationRouterType, as type: TabbarChildRouter) {
    childRouters[type] = router
  }
}

extension TabbarRouter {
  private func setupNewViewRouter() {
    let dependencies = NewDependencies(
      networkingService: tabbarDependencies.networkingService
    )
    let newNavigationController = configureNavigationControllerWithTabs(
      title: "New",
      image: UIImage()
    )
    let router = NewRouter(
      navigationController: newNavigationController,
      dependencies: dependencies
    )
    router.start()
    store(with: router, as: .new)
  }
  
  private func setupSearchViewRouter() {
    let dependencies = SearchDependencies(
      networkingService: tabbarDependencies.networkingService,
      cacheWrapper: CacheWrapper(base: Cache())
    )
    let searchNavigationController = configureNavigationControllerWithTabs(
      title: "Search",
      image: UIImage()
    )
    let router = SearchRouter(
      navigationController: searchNavigationController,
      dependencies: dependencies
    )
    router.start()
    store(with: router, as: .search)
  }
}

extension TabbarRouter {
  private func setupTabbarController() {
    let tabbarController: UITabBarController = {
      $0.tabBar.tintColor = Theme.Colors.PrimaryColor.mainColor
      $0.viewControllers = childRouters
        .sorted(by: { $0.0.rawValue < $1.0.rawValue })
        .map { $0.value.navigationController }
      return $0
    }(UITabBarController())
    self.tabbarController = tabbarController
    self.navigationController.isNavigationBarHidden = true
    self.navigationController.setViewControllers([self.tabbarController!], animated: false)
  }
}

extension TabbarRouter {
  private func configureNavigationControllerWithTabs(title: String, image: UIImage?) -> UINavigationController {
    let navigationController: UINavigationController = {
      $0.tabBarItem.title = title
      $0.tabBarItem.image = image
      return $0
    }(UINavigationController())
    return navigationController
  }
}
