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
  /// - Parameter networkService: Сервис по работе с сетью
  /// - Returns: Cобранный модуль `MainScreen`
  func createModule(_ networkService: NetworkService) -> MainScreenModule {
    let interactor = MainScreenInteractor(networkService: networkService)
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
