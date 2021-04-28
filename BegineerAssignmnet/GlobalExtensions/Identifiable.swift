//
//  Reusable.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Identifiable { }
extension UICollectionViewCell: Identifiable { }
extension UIViewController: Identifiable { }
