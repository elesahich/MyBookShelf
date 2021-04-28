//
//  BookDetailPresenter.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//  
//

import Foundation
import RxSwift
import struct RxCocoa.Driver

final class BookDetailPresenter: BookDetailPresenterInterface {
  let interactor: BookDetailInteractorInterface
  let router: BookDetailRouterInterface
  
  init(
    interactor: BookDetailInteractorInterface,
    router: BookDetailRouterInterface
  ) {
    self.interactor = interactor
    self.router = router
  }
  
  struct Input {
    let book: Book
    let viewDidLoad: Observable<Void>
    let saveAction: Observable<String>
  }
  
  struct Output {
    let memoObject: Driver<BookWithMemoObject?>
    let saveAction: Driver<Void>
  }
}

extension BookDetailPresenter {
  func transform(to inputs: Input) -> Output {
    weak var weakSelf = self
    
    let memoObject = inputs.viewDidLoad
      .flatMap { _ -> Observable<BookWithMemoObject?> in
        let object = weakSelf?.interactor.fetchMemobyISBN(isbn: inputs.book.isbn13)
        return .just(object)
      }
    
    let saveAction = inputs.saveAction
      .flatMap { memo -> Observable<Void> in
        weakSelf?.interactor.saveMemoWithISBN(isbn: inputs.book.isbn13, memo: memo)
        weakSelf?.router.popViewController()
        return .just(())
      }
        
    return .init(
      memoObject: memoObject.asDriver(onErrorDriveWith: .empty()),
      saveAction: saveAction.asDriver(onErrorDriveWith: .empty())
    )
  }
}
