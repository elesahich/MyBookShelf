//
//  BaseRouter.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/21.
//

import UIKit

protocol BaseRouterType: AnyObject {
  func start()
}

protocol NavigationRouterType: BaseRouterType {
  var navigationController: UINavigationController { get }
}
