//
//  BaseCollectionView.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//

import UIKit
import SnapKit

class BaseCollectionView: UIView {
  private let layoutConfig: LayoutConfig
  private(set) var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  init(layoutConfig: LayoutConfig, frame: CGRect = .zero) {
    self.layoutConfig = layoutConfig
    super.init(frame: frame)
    
    setupMainView()
  }
  
  required init?(coder: NSCoder) {
    self.layoutConfig = LayoutConfig(widthHeightRatio: 11/10)
    
    super.init(coder: coder)
    setupMainView()
  }
  
  private func setupMainView() {
    setupCollectionView()
  }
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
  private func setupCollectionView() {
    addSubview(collectionView)
    collectionView.delegate = self
    
    collectionView.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let viewWidth = UIScreen.main.bounds.width
    let calculated = viewWidth - (layoutConfig.interItemSpacing + layoutConfig.insets.left * 2)
    return CGSize(width: calculated / 2, height: calculated / 2 * layoutConfig.widthHeightRatio)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return layoutConfig.interItemSpacing
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return layoutConfig.interItemSpacing
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return layoutConfig.insets
  }
}

extension BaseCollectionView {
  struct LayoutConfig {
    let interItemSpacing: CGFloat = 10
    let insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    let numberOfItems: UInt = 2
    let widthHeightRatio: CGFloat
  }
}
