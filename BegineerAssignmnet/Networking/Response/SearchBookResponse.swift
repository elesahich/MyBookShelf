//
//  SearchBookResponse.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/26.
//

import Foundation

struct SearchBookResponse<T>: Decodable where T: Decodable {
  let error: String
  let total: String
  let page: String
  let books: [T]
}
