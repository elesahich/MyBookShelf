//
//  NewProtocols.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import UIKit
import RxSwift

protocol NewViewInterface: class {
  var presenter: NewPresenterInterface { get }
}

protocol NewInteractorInterface: class {
  var networking: Networking { get }

  func fetchNewBookfromAPI() -> Observable<[Book]>
}

protocol NewPresenterInterface: class {
  var router: NewRouterInterface { get }
  var interactor: NewInteractorInterface { get }
  
  func transform(to inputs: NewPresenter.Input) -> NewPresenter.Output
}

protocol NewRouterInterface: class {
  func showBookDetail(to model: Book)
}

