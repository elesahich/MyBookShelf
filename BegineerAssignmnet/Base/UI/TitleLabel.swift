//
//  TitleLabel.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import UIKit

class TitleLabel: UILabel {
  convenience init(
    color: UIColor = Theme.Colors.Texts.primary,
    font: UIFont = .systemFont(ofSize: 20, weight: .medium)
  ) {
    self.init()
    self.textColor = color
    self.font = font
    self.numberOfLines = 0
  }
  
  convenience init(
    color: UIColor = Theme.Colors.Texts.primary,
    font: UIFont = .systemFont(ofSize: 20, weight: .medium),
    numberOflines: Int = 2
  ) {
    self.init()
    self.textColor = color
    self.font = font
    self.numberOfLines = numberOflines
  }
}
