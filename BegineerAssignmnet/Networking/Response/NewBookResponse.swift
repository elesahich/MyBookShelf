//
//  NewViewResponse.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import Foundation

struct NewBookResponseType<T>: Decodable where T: Decodable {
  let error: String
  let total: String
  let books: [T]
}
