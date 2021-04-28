//
//  TabbarDependencies.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/21.
//

import Foundation

final class TabbarDependencies {
  let networkingService: Networking
  
  init(networkingService: Networking) {
    self.networkingService = networkingService
  }
}
