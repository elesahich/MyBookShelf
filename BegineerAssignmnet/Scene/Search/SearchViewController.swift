//
//  SearchView.swift
//  BegineerAssignmnet
//
//  Created by elesahich on 2021/04/22.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final class SearchViewController: UIViewController, SearchViewInterface {
  private let disposeBag = DisposeBag()
  private var bookListView: BaseCollectionView!
  let presenter: SearchPresenterInterface
  
  init(
    presenter: SearchPresenterInterface
  ) {
    self.presenter = presenter
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchViewController {
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

extension SearchViewController {
  private func bind() {
    let collectionView = bookListView.collectionView
    let searchText = navigationItem.searchController!.searchBar.rx.text.orEmpty
    
    let inputs = SearchPresenter.Input(
      searchText: searchText.distinctUntilChanged().filter { !$0.isEmpty },
      reachtoBottom: collectionView.rx.reachedBottom().asObservable(),
      modelSelected: collectionView.rx.modelSelected(Book.self).asObservable()
    )
    let outputs = presenter.transform(to: inputs)
    
    outputs.book
      .drive(collectionView.rx.items(
              cellIdentifier: BaseCollectionViewCell.identifier,
              cellType: BaseCollectionViewCell.self)
      ) { row, item, cell in
        cell.bind(to: item)
      }
      .disposed(by: disposeBag)
    
    outputs.modelSelected
      .drive()
      .disposed(by: disposeBag)
  }
}

extension SearchViewController {
  private func setupCollectionView() {
    let collectionView = bookListView.collectionView
    
    collectionView.register(
      BaseCollectionViewCell.self,
      forCellWithReuseIdentifier: BaseCollectionViewCell.identifier
    )

    collectionView.backgroundColor = Theme.Colors.Background.primary
    collectionView.keyboardDismissMode = .onDrag
  }
  
  private func setupMainView() {
    navigationItem.title = "Search Books"
    navigationController?.navigationBar.prefersLargeTitles = true
    addSearchBar(placeholder: "책을 검색해 보세요.")
  }
}
