//
//  ScrollView+Reactive.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/26.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
  func reachedBottom(offset: CGFloat = 100.0) -> ControlEvent<Void> {
      let source = contentOffset.map { contentOffset in
          let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
          let y = contentOffset.y + self.base.contentInset.top
          let threshold = max(offset, self.base.contentSize.height - visibleHeight)
          
          return y >= threshold
      }.distinctUntilChanged()
      .filter { $0 }
      .map { _ in () }
      return ControlEvent(events: source)
  }
}
