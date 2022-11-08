//
//  MappingService.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import Foundation

protocol MappingService {
  
  /// Делает маппинг из `JSON` в структуру данных типа `Generic`
  /// - parameters:
  ///  - result: модель данных с сервера
  ///  - to: В какой тип данных маппим
  /// - returns: Результат маппинга в структуру `Generic`
  func map<ResponseType: Codable>(_ result: Data?, to _: ResponseType.Type) -> ResponseType?
}

final class MappingServiceImpl: MappingService {
  func map<ResponseType: Codable>(_ result: Data?, to _: ResponseType.Type) -> ResponseType? {
    guard let data = result else {
      return nil
    }
    
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(ResponseType.self, from: data)
      return result
    } catch {
      return nil
    }
  }
}
