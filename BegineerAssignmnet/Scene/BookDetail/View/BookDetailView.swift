//
//  BookDetailView.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class BookDetailView: UIView {
  private let scrollView = UIScrollView()
  private let contentsView = UIView()
  
  private let bookImageView: UIImageView = {
    $0.contentMode = .scaleAspectFit
    return $0
  }(UIImageView())
  private let titleLabel = TitleLabel(
    font: .systemFont(ofSize: 20, weight: .bold),
    numberOflines: 2
  )
  private let subtitleLabel = ContentsLabel(
    color: .systemGray,
    font: .systemFont(ofSize: 16, weight: .light)
  )
  private let isbnLabel = ContentsLabel(font: .systemFont(ofSize: 16, weight: .light))
  private let priceLabel = ContentsLabel(font: .systemFont(ofSize: 16, weight: .light))
  private(set) var textView: UITextView = {
    $0.layer.borderWidth = 0.5
    $0.layer.borderColor = UIColor.systemGray.cgColor
    $0.layer.cornerRadius = 5
    return $0
  }(UITextView())
  
  lazy var stackView: UIStackView = { stackView in
    stackView.alignment = .fill
    stackView.axis = .vertical
    [titleLabel, subtitleLabel, isbnLabel, priceLabel].forEach { view in
      stackView.addArrangedSubview(view)
    }
    return stackView
  }(UIStackView())
  
  private let disposeBag = DisposeBag()
  
  // initiailize
  private let book: Book
  private var animator: UIViewPropertyAnimator?
  
  init(
    book: Book,
    frame: CGRect
  ) {
    self.book = book
    
    super.init(frame: frame)
    setupDetailView()
    layoutBookDetilView()
    bind()
    addtabGestureToHideKeyboard()
    handleBottomOffset()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(corder:) is not supported")
  }
}

extension BookDetailView {
  private func layoutBookDetilView() {
    [bookImageView, stackView, textView]
      .forEach { contentsView.addSubview($0) }
    scrollView.addSubview(contentsView)
    addSubview(scrollView)
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    // enum으로 변경좀~!
    bookImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(20)
      $0.leading.equalToSuperview().inset(20)
      $0.width.equalTo(170)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(bookImageView.snp.centerY).offset(-50)
      $0.leading.equalTo(bookImageView.snp.trailing).offset(20)
      $0.trailing.equalToSuperview().inset(20)
    }
    
    textView.snp.makeConstraints {
      $0.top.equalTo(bookImageView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(20)
    }
    
    contentsView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.width.height.top.bottom.equalTo(scrollView)
    }
  }
  
  private func setupDetailView() {
    self.backgroundColor = Theme.Colors.Background.primary
  }
  
  private func bind() {
    bookImageView.kf.setImage(with: URL(string: book.image))
    titleLabel.text = book.title
    subtitleLabel.text = book.subtitle
    isbnLabel.text = book.isbn13
    priceLabel.text = book.price
  }
}

extension BookDetailView {
  private func addtabGestureToHideKeyboard() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    addGestureRecognizer(gesture)
  }
  
  @objc private func dismissKeyboard() {
    endEditing(true)
  }
}

extension BookDetailView {
  private func handleBottomOffset() {
    enum KeyboardHandleType {
      case begin(Void)
      case resign(Void)
    }
    
    Observable.merge(
      textView.rx.didBeginEditing.map(KeyboardHandleType.begin),
      textView.rx.didEndEditing.map(KeyboardHandleType.resign)
    )
    .bind(onNext: { [weak self] type in
      switch type {
      case .begin:
        self?.animator = UIViewPropertyAnimator.runningPropertyAnimator(
          withDuration: 0.3,
          delay: 0,
          options: .curveEaseOut,
          animations: {
            self?.scrollView.contentOffset.y += 150
          })
        
        self?.animator?.startAnimation()
      case .resign:
        self?.animator = UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut,
            animations: {
              self?.scrollView.contentOffset.y -= 150
            })
        
        self?.animator?.startAnimation()
      }
    })
    .disposed(by: disposeBag)
  }
}
