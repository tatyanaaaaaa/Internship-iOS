//
//  MainScreenAssembly.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// Сборщик `MainScreen`
final class MainScreenAssembly {
  
  /// Собирает модуль `MainScreen`
  /// - Parameters:
  ///  - networkService: Сервис по работе с сетью
  ///  - mappingService: Делает маппинг из `JSON` в структуру данных типа `Generic`
  /// - Returns: Cобранный модуль `MainScreen`
  func createModule(_ networkService: NetworkService,
                    _ mappingService: MappingService) -> MainScreenModule {
    let interactor = MainScreenInteractor(networkService: networkService,
                                          mappingService: mappingService)
    let view = MainScreenView()
    let factory = MainScreenFactory()
    let presenter = MainScreenViewController(interactor: interactor,
                                             moduleView: view,
                                             factory: factory)
    
    view.output = presenter
    interactor.output = presenter
    factory.output = presenter
    return presenter
  }
}
