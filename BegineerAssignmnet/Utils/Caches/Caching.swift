//
//  Caching.swift
//  placepic
//
//  Created by elesahich on 2021/03/15.
//  Copyright © 2021 elesahich. All rights reserved.
//

import Foundation

protocol Caching {
  associatedtype Key: Hashable
  associatedtype Value
  
  subscript(key: Key) -> Value? { get set }
  
  func insert(_ value: Value, forKey key: Key)
  func value(forKey key: Key) -> Value?
  func removeValue(forKey key: Key)
}
