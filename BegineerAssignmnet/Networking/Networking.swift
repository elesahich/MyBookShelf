//
//  Networking.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import Foundation
import RxSwift

protocol Networking {
  func requestObservable<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response>
}

protocol NetworkBase {
  var networkingService: Networking { get }
}
