//
//  NetworkService.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

protocol NetworkService {
  
  /// Сделать запрос в сеть
  ///  - Parameters:
  ///   - url: Адрес запроса
  ///   - httpMethod: Метод запроса
  ///   - additionalHeaders: Хедеры
  ///   - Reuterns: Результат выполнения
  func performRequestWith(url: URL?,
                          httpMethod: NetworkRequestHTTPMethod,
                          additionalHeaders: [String: String],
                          completion: ((Result<Data?, NetworkError>) -> Void)?)
}

final class NetworkServiceImpl: NetworkService {
  
  // MARK: - Private variable
  
  private lazy var session: URLSession = {
    let appearance = Appearance()
    let config = URLSession.shared
    
    /// Время ожидания для запросов URL
    config.configuration.timeoutIntervalForRequest = appearance.timeOutInterval
    
    /// Время ожидания для ответов URL
    config.configuration.timeoutIntervalForResource = appearance.timeOutInterval
    return config
  }()
  
  private lazy var networkReachability: NetworkReachability? = {
    DefaultNetworkReachability()
  }()
  
  func performRequestWith(url: URL?,
                          httpMethod: NetworkRequestHTTPMethod,
                          additionalHeaders: [String: String] = [:],
                          completion: ((Result<Data?, NetworkError>) -> Void)?) {
    guard let url = url else {
      completion?(.failure(.invalidURLRequest))
      return
    }
    
    var requestURL = URLRequest(url: url)
    requestURL.cachePolicy = getCachePolicy()
    requestURL.httpMethod = httpMethod.rawValue
    
    additionalHeaders.forEach {
      requestURL.setValue($1, forHTTPHeaderField: $0)
    }
    
    guard networkReachability?.isReachable ?? false else {
      completion?(.failure(.noInternetConnection))
      return
    }
    
    DispatchQueue.global(qos: .default).async { [weak self] in
      guard let self = self else { return }
      let task = self.session.dataTask(with: requestURL) { data, response, error in
        if error != nil {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? .zero
          completion?(.failure(.unacceptedHTTPStatus(code: statusCode)))
        }
        completion?(.success(data))
        UserDefaults.standard.setValue(Date(), forKey: Appearance().keyCachePolicyDate)
      }
      task.resume()
    }
  }
}

// MARK: - Private

private extension NetworkServiceImpl {
  func getCachePolicy() -> URLRequest.CachePolicy {
    let appearance = Appearance()
    
    if let dateLastSession = UserDefaults.standard.value(forKey: appearance.keyCachePolicyDate) as? Date {
      // Время последнего запроса + 1 час
      let maximumDateLastSession = dateLastSession.addingTimeInterval(appearance.oneHour)
      
      // Один час с последнего запроса вышел
      if maximumDateLastSession < Date() {
        return .returnCacheDataDontLoad
      }
    }
    return .reloadIgnoringLocalCacheData
  }
}

// MARK: - Appearance

private extension NetworkServiceImpl {
  struct Appearance {
    let timeOutInterval: Double = 90
    let keyCachePolicyDate = "key_cache_policy_date"
    let oneHour: Double = 3_600
  }
}
