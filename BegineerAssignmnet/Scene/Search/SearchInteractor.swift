//
//  SearchInteractor.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/26.
//

import Foundation
import RxSwift

final class SearchInteractor: SearchInteractorInterface {
  let networking: Networking
  let cacheWrapper: CacheWrapper<String, [Book]>
  
  init(
    networking: Networking,
    cacheWrapper: CacheWrapper<String, [Book]>
  ) {
    self.networking = networking
    self.cacheWrapper = cacheWrapper
  }
}

extension SearchInteractor {
  private func searchBookEndpoint(_ bookname: String,_ page: Int) -> Endpoint<SearchBookResponse<Book>> {
    let url = URLBuilder()
      .set(path: "search/\(bookname)/\(page)")
      .build()!
        
    return Endpoint(method: .get, url: url)
  }
  
  private func searchBookbyName(bookname: String, page: Int) -> Observable<[Book]> {
    if let cache = cacheWrapper[bookname + String(page)] {
      return .just(cache)
    }
    
    return networking.requestObservable(searchBookEndpoint(bookname, page))
      .do { self.cacheWrapper[bookname + String(page)] = $0.books }
      .map { $0.books }
  }
    
  func fetchPaginatedSearchResult(
    searchText: Observable<String>,
    loadNextPage: Observable<Void>
  ) -> Observable<[Book]> {
    let source = PaginationUISource(search: searchText, loadNextPage: loadNextPage)
    let sink = PaginationSink(ui: source, loadData: searchBookbyName)
    
    return sink.elements
  }
}
