//
//  UIViewController+Extensions.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//

import UIKit

extension UIViewController {
  func addSearchBar(placeholder: String? = nil) {
    let searchController = UISearchController()
    searchController.searchBar.tintColor = Theme.Colors.Components.primary
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    
    if let placeholder = placeholder {
      searchController.searchBar.placeholder = placeholder
    }
  }
}
