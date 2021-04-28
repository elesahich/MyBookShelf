//
//  PaginationSInk.swift
//  placepic
//
//  Created by elesahich on 2021/03/27.
//  Copyright © 2021 elesahich. All rights reserved.
//

import RxSwift

struct PaginationUISource {
  let search: Observable<String>
  let refresh: Observable<Void>? = nil
  let loadNextPage: Observable<Void>
}

struct PaginationSink<T> {
  let isLoading: Observable<Bool>
  let elements: Observable<[T]>
  let error: Observable<Error>
}

extension PaginationSink {
  init(
    ui: PaginationUISource,
    loadData: @escaping (_ bookName: String, _ page: Int) -> Observable<[T]>
  ) {
    let loadResults = BehaviorSubject<[Int: [T]]>(value: [:])
    
    let currentMaxPage = loadResults
      .map { $0.keys }
      .map { $0.max() ?? 1 }
    
    let loadNext = ui.loadNextPage
      .withLatestFrom(currentMaxPage)
      .map { $0 + 1 }
      
    let searchStart = ui.search
      .map { _ in -1 }
    
    let start = Observable.merge(loadNext, searchStart, Observable.just(1))
    
    let page = Observable.combineLatest(start, ui.search)
      .flatMap { page, text -> Observable<Event<(pageNumber: Int, items: [T])>> in
        return Observable.combineLatest(
          Observable.just(page),
          loadData(text, page == -1 ? 1 : page).asObservable()
        ) { (pageNumber: $0, items: $1) }
        .materialize()
        .filter { $0.isCompleted == false }
      }
        
    _ = page
      .compactMap { $0.element }
      .withLatestFrom(loadResults) { (pages: $1, newPage: $0) }
      .filter { $0.newPage.pageNumber == -1 || !$0.newPage.items.isEmpty }
      .map { $0.newPage.pageNumber == -1 ? [1: $0.newPage.items] : $0.pages.merging([$0.newPage], uniquingKeysWith: { $1 }) }
      .bind(to: loadResults)
    
    let _isLoading = Observable
      .merge(
        start.map { _ in 1 },
        page.map { _ in -1 }
      )
      .scan(0, accumulator: + )
      .map { $0 > 0 }
      .distinctUntilChanged()
    
    let _elements = loadResults
      .map { $0.sorted(by: { $0.key < $1.key }).flatMap { $0.value } }
    
    let _error = page
      .map { $0.error }
      .filter { $0 != nil }
      .map { $0! }
    
    isLoading = _isLoading
    elements = _elements
    error = _error
  }
}
