//
//  MainScreenInteractor.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol MainScreenInteractorOutput: AnyObject {}

/// События которые отправляем от Presenter к Interactor
protocol MainScreenInteractorInput {}

/// Интерактор
final class MainScreenInteractor: MainScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Private properties
  
  private let networkService: NetworkService
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameter networkService: Сервис по работе с сетью
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  // MARK: - Private properties
}

// MARK: - Appearance

private extension MainScreenInteractor {
  struct Appearance {}
}
