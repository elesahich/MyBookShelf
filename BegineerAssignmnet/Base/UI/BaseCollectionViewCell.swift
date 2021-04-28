//
//  BaseCollectionViewCell.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell {
  private let titleLabel = TitleLabel(
    font: .systemFont(ofSize: 16, weight: .bold),
    numberOflines: 1
  )
  private let subtitleLabel = ContentsLabel(font: .systemFont(ofSize: 12, weight: .light), numberOfLines: 1)
  private let priceLabel = ContentsLabel(font: .systemFont(ofSize: 12, weight: .light), numberOfLines: 1)
  private let imageView:  UIImageView = {
    $0.contentMode = .scaleAspectFit
    return $0
  }(UIImageView(frame: .zero))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionViewCell()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupCollectionViewCell()
  }
  
  enum NewViewCellConstant {
    static let linespacing = 10.0
    static let itemspacing = 10.0
    static let horizontal = 10.0
    static let vertical = 10.0
    static let imageHeight = 115.0
  }
}

extension BaseCollectionViewCell {
  private func setupCollectionViewCell() {
    layer.masksToBounds = true
    backgroundColor = Theme.Colors.Background.container
    layer.cornerRadius = 5

    setupMainView()
  }
  
  private func setupMainView() {
    let width = UIScreen.main.bounds.width
    
    [titleLabel, subtitleLabel, priceLabel, imageView].forEach { addSubview($0) }
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(CGFloat(NewViewCellConstant.imageHeight) * (width / 375))
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(NewViewCellConstant.vertical)
      $0.leading.trailing.equalToSuperview().inset(NewViewCellConstant.horizontal)
      $0.height.equalTo(17)
    }
        
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(NewViewCellConstant.horizontal)
      $0.height.equalTo(15)
    }
    
    priceLabel.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel.snp.bottom).offset(NewViewCellConstant.vertical/2)
      $0.leading.trailing.equalToSuperview().inset(NewViewCellConstant.horizontal)
      $0.bottom.equalToSuperview().inset(NewViewCellConstant.vertical/2)
    }
  }
}

// Book은 ISBN이 key가 될 수 있당..
extension BaseCollectionViewCell {
  func bind(to model: Book) {
    self.imageView.kf.setImage(with: URL(string: model.image))
    self.titleLabel.text = model.title
    self.subtitleLabel.text = model.subtitle
    self.priceLabel.text = model.price
  }
}
