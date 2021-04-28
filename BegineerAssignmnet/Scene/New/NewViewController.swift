//
//  NewView.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NewViewController: UIViewController {
  private var bookListView: BaseCollectionView!
  private let disposeBag = DisposeBag()
  private let presenter: NewPresenterInterface
  
  init(presenter: NewPresenterInterface) {
    self.presenter = presenter
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewViewController {
  override func loadView() {
    bookListView = BaseCollectionView(layoutConfig: .init(widthHeightRatio: 11/10))
    view = bookListView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    setupCollectionView()
    
    bind()
  }
}

extension NewViewController {
  private func bind() {
    let inputs = NewPresenter.Input(
      viewWillAppear: rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
      modelSelected: bookListView.collectionView.rx.modelSelected(Book.self).asObservable()
    )
    
    let outputs = presenter.transform(to: inputs)
    
    outputs.bookList
      .drive(bookListView.collectionView.rx.items(
              cellIdentifier: BaseCollectionViewCell.identifier,
              cellType: BaseCollectionViewCell.self)
      ) { index, item, cell in
        cell.bind(to: item)
      }
      .disposed(by: disposeBag)
    
    outputs.sendDetailView
      .drive()
      .disposed(by: disposeBag)
  }
}

extension NewViewController {
  private func setupCollectionView() {
    let collectionView = bookListView.collectionView
    
    collectionView.register(
      BaseCollectionViewCell.self,
      forCellWithReuseIdentifier: BaseCollectionViewCell.identifier
    )

    collectionView.backgroundColor = Theme.Colors.Background.primary
  }
  
  private func setupMainView() {
    navigationItem.title = "New Books"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
