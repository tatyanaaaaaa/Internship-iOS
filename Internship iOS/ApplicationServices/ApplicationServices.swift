//
//  ApplicationServices.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import Foundation

/// Протокол, описывающий все зависимости системы.
protocol ApplicationServices {
  
  /// Сервис по работе с сетью
  var networkService: NetworkService { get }
  
  /// Сервис маппинга
  var mappingService: MappingService { get }
}

// MARK: - Реализация ApplicationServices

final class ApplicationServicesImpl: ApplicationServices {
  var mappingService: MappingService {
    MappingServiceImpl()
  }
  
  var networkService: NetworkService {
    NetworkServiceImpl()
  }
}
