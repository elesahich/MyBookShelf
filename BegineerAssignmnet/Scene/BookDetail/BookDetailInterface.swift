//
//  BookDetailInterface.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//  
//

import Foundation

protocol BookDetailPresenterInterface: class {
  var interactor: BookDetailInteractorInterface { get }
  var router: BookDetailRouterInterface { get }
  
  func transform(to inputs: BookDetailPresenter.Input) -> BookDetailPresenter.Output
}

protocol BookDetailInteractorInterface: class {
  func fetchMemobyISBN(isbn: String) -> BookWithMemoObject?
  func saveMemoWithISBN(isbn: String, memo: String) -> Void
}

protocol BookDetailRouterInterface: class {
  func popViewController()
}
