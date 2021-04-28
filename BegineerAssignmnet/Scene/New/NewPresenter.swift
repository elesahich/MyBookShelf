//
//  NewPresenter.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import UIKit
import RxSwift
import struct RxCocoa.Driver

final class NewPresenter: NewPresenterInterface {
  let router: NewRouterInterface
  let interactor: NewInteractorInterface
  
  init(
    router: NewRouterInterface,
    interactor: NewInteractorInterface
  ) {
    self.router = router
    self.interactor = interactor
  }
  
  struct Input {
    let viewWillAppear: Observable<Void>
    let modelSelected: Observable<Book>
  }
    
  struct Output {
    let bookList: Driver<[Book]>
    let sendDetailView: Driver<Void>
  }
}

extension NewPresenter {
  func transform(to inputs: Input) -> Output {
    weak var weakSelf = self
    
    let bookList = inputs.viewWillAppear
      .flatMapLatest { _ -> Observable<[Book]> in
        return weakSelf?.interactor.fetchNewBookfromAPI() ?? .empty()
      }
    
    let sendDetailView = inputs.modelSelected
      .flatMapLatest { book -> Observable<Void> in
        weakSelf?.router.showBookDetail(to: book)
        return .just(())
      }
    
    return .init(
      bookList: bookList.asDriver(onErrorDriveWith: .empty()),
      sendDetailView: sendDetailView.asDriver(onErrorDriveWith: .empty())
    )
  }
}
