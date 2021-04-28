//
//  BookWithMemo.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/27.
//

import Foundation
import RealmSwift

class BookWithMemoObject: Object {
  @objc dynamic var isbn: String = ""
  @objc dynamic var memo: String = ""
  
  override static func primaryKey() -> String? { return "isbn" }
  
  convenience init(isbn: String, memo: String) {
    self.init()
    
    self.isbn = isbn
    self.memo = memo
  }
}
