//
//  Books.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import Foundation

class Book: Decodable {
  let title: String
  let subtitle: String
  let isbn13: String
  let price: String
  let image: String
  let url: String
}
