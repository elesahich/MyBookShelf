//
//  NewRouter.swift
//  BegineerAssignmnet
//
//  Created by elesahich on 2021/04/21.
//

import UIKit
import RealmSwift

final class NewRouter: NavigationRouterType, NewRouterInterface {
  let navigationController: UINavigationController
  let dependencies: NewDependencies
  
  init(
    navigationController: UINavigationController,
    dependencies: NewDependencies
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    showNewBookList()
  }
}

extension NewRouter {
  private func showNewBookList() {
    let interactor = NewInteractor(dependencies: dependencies)
    let presenter = NewPresenter(
      router: self,
      interactor: interactor
    )
    
    let viewController = NewViewController(presenter: presenter)
    navigationController.show(viewController, sender: nil)
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
