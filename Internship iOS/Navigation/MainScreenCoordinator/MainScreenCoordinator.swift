//
//  MainScreenCoordinator.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// События которые отправляем из `текущего координатора` в  `другой координатор`
protocol MainScreenCoordinatorOutput: AnyObject {}

/// События которые отправляем из `другого координатора` в  `текущий координатор`
protocol MainScreenCoordinatorInput {
  
  /// События которые отправляем из `текущего координатора` в  `другой координатор`
  var output: MainScreenCoordinatorOutput? { get set }
}

typealias MainScreenCoordinatorProtocol = MainScreenCoordinatorInput & Coordinator

final class MainScreenCoordinator: MainScreenCoordinatorProtocol {
  
  // MARK: - Internal variables
  
  weak var output: MainScreenCoordinatorOutput?
  
  // MARK: - Private variables
  
  private let navigationController: UINavigationController
  private let services: ApplicationServices
  private var mainScreenModule: MainScreenModule?
  private var anyCoordinator: Coordinator?
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///   - navigationController: UINavigationController
  ///   - services: Сервисы приложения
  init(_ navigationController: UINavigationController,
       _ services: ApplicationServices) {
    self.navigationController = navigationController
    self.services = services
  }
  
  // MARK: - Internal func
  
  func start() {
    let mainScreenModule = MainScreenAssembly().createModule(services.networkService,
                                                             services.mappingService)
    self.mainScreenModule = mainScreenModule
    self.mainScreenModule?.moduleOutput = self
    
    navigationController.pushViewController(mainScreenModule, animated: true)
  }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {
  func failureNoInternetConnection() {
    showAlertWith(title: Appearance().failureNoInternetConnection)
  }
  
  func failureOther() {
    showAlertWith(title: Appearance().failureOther)
  }
}

// MARK: - Private

extension MainScreenCoordinator {
  func showAlertWith(title: String) {
    let alert = UIAlertController(title: title,
                                  message: "",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Appearance().alertOk,
                                  style: .default,
                                  handler: { _ in }))
    mainScreenModule?.present(alert, animated: true, completion: nil)
  }
}

// MARK: - Appearance

private extension MainScreenCoordinator {
  struct Appearance {
    let alertOk = "Ok"
    let failureNoInternetConnection = "Ошибка сети"
    let failureOther = "Что-то пошло не так"
  }
}
