//
//  SearchPresenter.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/26.
//

import Foundation
import RxSwift
import struct RxCocoa.Driver

final class SearchPresenter: SearchPresenterInterface {
  let interactor: SearchInteractorInterface
  let router: SearchRouterInterface
  
  init(
    interactor: SearchInteractorInterface,
    router: SearchRouterInterface
  ) {
    self.interactor = interactor
    self.router = router
  }
  
  struct Input {
    let searchText: Observable<String>
    let reachtoBottom: Observable<Void>
    let modelSelected: Observable<Book>
  }
  
  struct Output {
    let book: Driver<[Book]>
    let modelSelected: Driver<Void>
  }
}

extension SearchPresenter {
  func transform(to inputs: Input) -> Output {
    weak var weakSelf = self
    
    let searchedItem = interactor.fetchPaginatedSearchResult(
      searchText: inputs.searchText.debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance),
      loadNextPage: inputs.reachtoBottom
    )
    .share()
    
    let modelSelected = inputs.modelSelected
      .flatMap { book -> Observable<Void> in
        weakSelf?.router.showBookDetail(to: book)
        return .just(())
      }
      
    return .init(
      book: searchedItem.asDriver(onErrorDriveWith: .empty()),
      modelSelected: modelSelected.asDriver(onErrorDriveWith: .empty())
    )
  }
} 	
