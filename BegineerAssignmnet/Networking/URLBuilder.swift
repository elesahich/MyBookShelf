//
//  URLBuilder.swift
//  BegineerAssignmnet
//
//  Created by Ian on 2021/04/22.
//

import Foundation

final class URLBuilder {
  private var components: URLComponents
  private let version: String?
  
  init(
    scheme: String = "https",
    host: String = AppConfiguration.API.host,
    version: String? = AppConfiguration.API.version
  ) {
    self.components = URLComponents()
    self.components.scheme = scheme
    self.components.host = host
    self.version = version
  }
  
  func set(port: Int) -> URLBuilder {
    components.port = port
    return self
  }
  
  func set(path: String) -> URLBuilder {
    var fullpath = ""
    
    if let version = version {
      fullpath.appendPathComponent(version)
    }
    
    fullpath.appendPathComponent(path)
    components.path = fullpath
    return self
  }
  
  func addQueryItem(name: String, value: String) -> URLBuilder {
    if components.queryItems == nil {
      components.queryItems = []
    }
    components.queryItems?.append(URLQueryItem(name: name, value: value))
    return self
  }
  
  func build() -> URL? {
    return components.url
  }
}

private extension String {
  mutating func appendPathComponent(_ component: String) {
    guard !component.isEmpty else { return }
    
    if !component.hasPrefix("/") {
      append("/")
    }
    append(component)
  }
}
