//
//  BookDetailDependencies.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//

import Foundation
import RealmSwift

struct BookDetailDependencies: NetworkBase {
  let networkingService: Networking
  let realm: Realm
  
  init(
    networkingService: Networking,
    realmInstance: Realm
  ) {
    self.networkingService = networkingService
    self.realm = realmInstance
  }  
}
