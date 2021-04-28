//
//  ContentsLabel.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import UIKit

class ContentsLabel: UILabel {
  convenience init(
    color: UIColor = Theme.Colors.Texts.secondary,
    font: UIFont = .systemFont(ofSize: 14, weight: .regular),
    numberOfLines: Int = 0
  ) {
    self.init()
    self.textColor = color
    self.font = font
    self.numberOfLines = numberOfLines
  }
}
