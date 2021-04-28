//
//  SearchRouter.swift
//  BegineerAssignmnet
//
//  Created by elesahich on 2021/04/21.
//

import UIKit
import RealmSwift

final class SearchRouter: NavigationRouterType, SearchRouterInterface {
  let navigationController: UINavigationController
  private let dependencies: SearchDependencies
  
  init(
    navigationController: UINavigationController,
    dependencies: SearchDependencies
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    showSearchView()
  }
}

extension SearchRouter {
  private func showSearchView() {
    let interactor = SearchInteractor(
      networking: dependencies.networkingService,
      cacheWrapper: dependencies.cacheWrapper
    )
    let presenter = SearchPresenter(
      interactor: interactor,
      router: self
    )

    let searchViewController = SearchViewController(
      presenter: presenter
    )
    navigationController.show(searchViewController, sender: nil)
  }
  
  func showBookDetail(to model: Book) {
    let dependencies = BookDetailDependencies(
      networkingService: self.dependencies.networkingService,
      realmInstance: try! Realm()
    )
    let interactor = BookDetailInteractor(dependencies: dependencies)
    let router = BookDetailRouter(
      navigationController: navigationController,
      dependencies: dependencies
    )
    let presenter = BookDetailPresenter(
      interactor: interactor,
      router: router
    )
    
    let bookDetailViewController = BookDetailViewController(
      book: model,
      presenter: presenter
    )
    bookDetailViewController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(bookDetailViewController, animated: true)
  }
}
