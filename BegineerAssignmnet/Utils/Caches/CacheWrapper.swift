//
//  CacheWrapper.swift
//  placepic
//
//  Created by elesahich on 2021/03/15.
//  Copyright © 2021 elesahich. All rights reserved.
//

import Foundation

final class CacheWrapper<K: Hashable, V>: Caching {
  typealias Key = K
  typealias Value = V
  
  private let insertAction: (Value, Key) -> Void
  private let getAction: (Key) -> Value?
  private let removeAction: (Key) -> Void
  
  init<Cache: Caching>(base: Cache) where Cache.Key == K, Cache.Value == V {
    self.insertAction = base.insert
    self.getAction = base.value
    self.removeAction = base.removeValue
  }
  
  func insert(_ value: V, forKey key: K) {
    insertAction(value, key)
  }
  
  func value(forKey key: K) -> V? {
    getAction(key)
  }
  
  func removeValue(forKey key: K) {
    removeAction(key)
  }
  
  subscript(key: Key) -> Value? {
    get {
      value(forKey: key)
    }
    set {
      guard let value = newValue else {
        removeValue(forKey: key)
        return
      }
      
      insert(value, forKey: key)
    }
  }
}
