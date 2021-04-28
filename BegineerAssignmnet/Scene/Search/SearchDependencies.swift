//
//  SearchDependencies.swift
//  BegineerAssignmnet
//
//  Created by elesahich on 2021/04/21.
//

import Foundation

struct SearchDependencies: NetworkBase {
  let networkingService: Networking
  let cacheWrapper: CacheWrapper<String, [Book]>
  
  init(
    networkingService: Networking,
    cacheWrapper: CacheWrapper<String, [Book]>
  ) {
    self.networkingService = networkingService
    self.cacheWrapper = cacheWrapper
  }
}
