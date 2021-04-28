//
//  NetworkingService.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class NetworkingService {
  private let sessionManager: Alamofire.Session
  private let requestQueue: DispatchQueue
  
  init(
    configuration: URLSessionConfiguration = .default,
    requestQueue: DispatchQueue = DispatchQueue(label: "myAssignment.alamofireQueue")
  ) {
    self.sessionManager = Alamofire.Session(configuration: configuration)
    self.requestQueue = requestQueue
  }
}

extension NetworkingService: Networking {
  func requestObservable<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response> {
    return sessionManager.rx.request(
      endpoint.method,
      endpoint.url,
      parameters: endpoint.parameters,
      encoding: endpoint.encoding,
      headers: endpoint.headers
    )
    .responseData()
    .debug()
    .map { request, data -> Response in
      return try endpoint.decode(data)
    }
    .share()
  }
}

