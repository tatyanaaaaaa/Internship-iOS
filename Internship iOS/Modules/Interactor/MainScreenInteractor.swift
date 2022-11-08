//
//  MainScreenInteractor.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol MainScreenInteractorOutput: AnyObject {
  
  /// Подключение к Интернету отсутствует
  func failureNoInternetConnection()
  
  /// Что то пошло не так
  func failureOther()
  
  /// Был получен контент
  ///  - Parameter content: Моделька данных
  func didReceiveContent(_ content: MainScreenModel)
}

/// События которые отправляем от Presenter к Interactor
protocol MainScreenInteractorInput {
  
  /// Загрузить контент
  func getContent()
}

/// Интерактор
final class MainScreenInteractor: MainScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Private properties
  
  private let networkService: NetworkService
  private let mappingService: MappingService
  
  // MARK: - Initialization
  
  /// Инициализатор
  /// - Parameters:
  ///  - networkService: Сервис по работе с сетью
  ///  - mappingService: Делает маппинг из `JSON` в структуру данных типа `Generic`
  init(networkService: NetworkService,
       mappingService: MappingService) {
    self.networkService = networkService
    self.mappingService = mappingService
  }
  
  // MARK: - Internal func
  
  func getContent() {
    networkService.performRequestWith(url: Appearance().url,
                                      httpMethod: .get,
                                      additionalHeaders: [:]) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          if let model = self?.mappingService.map(data, to: MainScreenModel.self) {
            self?.output?.didReceiveContent(model)
          } else {
            self?.output?.failureOther()
          }
        case .failure(let typeError):
          switch typeError {
          case .noInternetConnection:
            self?.output?.failureNoInternetConnection()
          default:
            self?.output?.failureOther()
          }
        }
      }
    }
  }
}

// MARK: - Appearance

private extension MainScreenInteractor {
  struct Appearance {
    let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
  }
}
