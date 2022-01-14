//
//  Resource.swift
//  BudgetTrackeriOS
//
//  Created by Jonathan Wong on 4/15/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import Foundation

enum ApiError: Error {
  case notFound // 404
  case serverError // 5xx
  case requestError // 4xx
  case jsonError
}

class ApiClient {

  let session: URLSession
  let baseURL = "http://localhost:8080/v1/"
  var resourceURL: URL
  
  var path: String? {
    didSet {
      if let path = path, let url = URL(string: baseURL)?.appendingPathComponent(path) {
        resourceURL = url
      }
    }
  }

  convenience init(session: URLSession) {
    self.init(session: session, resourcePath: nil)
  }
  
  init(session: URLSession, resourcePath: String?) {
    self.session = session

    guard let resourceURL = URL(string: baseURL) else {
      fatalError()
    }
    if let resourcePath = resourcePath {
      self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
    } else {
      self.resourceURL = resourceURL
    }
  }

  func fetchResource<T>(completion: @escaping (Result<T, ApiError>) -> Void) where T: Codable {
    let dataTask = session.dataTask(with: resourceURL) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.jsonError))
        return
      }
      do {
        let jsonDecoder = JSONDecoder()
        let resource = try jsonDecoder.decode(T.self, from: jsonData)
        completion(.success(resource))
      } catch {
        let bodyString = String(data: data!, encoding: .utf8)
        print("error \(String(describing: bodyString))")
        completion(.failure(.serverError))
      }
    }
    dataTask.resume()
  }
  
  func fetchResources<T>(completion: @escaping (Result<[T], ApiError>) -> Void) where T: Codable {
    let dataTask = session.dataTask(with: resourceURL) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure(.jsonError))
        return
      }
      do {
        let jsonDecoder = JSONDecoder()
        let resources = try jsonDecoder.decode([T].self, from: jsonData)
        completion(.success(resources))
      } catch {
        let bodyString = String(data: data!, encoding: .utf8)
        print("error \(String(describing: bodyString))")
        completion(.failure(.serverError))
      }
    }
    dataTask.resume()
  }

  func save(fromPath: String,
            fromResourceId: UUID,
            toPath: String,
            toResourceId: UUID,
            completion: @escaping (Int) -> Void) {
    path = "\(fromPath)/\(fromResourceId)/\(toPath)/\(toResourceId)"
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "POST"
    let dataTask = session.dataTask(with: urlRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      completion(httpResponse.statusCode)
    }
    dataTask.resume()
  }
  
  func delete(fromPath: String,
            fromResourceId: UUID,
            toPath: String,
            toResourceId: UUID,
            completion: @escaping (Int) -> Void) {
    path = "\(fromPath)/\(fromResourceId)/\(toPath)/\(toResourceId)"
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "DELETE"
    let dataTask = session.dataTask(with: urlRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      completion(httpResponse.statusCode)
    }
    dataTask.resume()
  }
}
