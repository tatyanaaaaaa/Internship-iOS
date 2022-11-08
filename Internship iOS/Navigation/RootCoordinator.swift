//
//  RootCoordinator.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

final class RootCoordinator: Coordinator {
  
  // MARK: - Private variables
  
  private let window: UIWindow
  private let navigationController = UINavigationController()
  private let services: ApplicationServices = ApplicationServicesImpl()
  private var coordinator: Coordinator?
  
  // MARK: - Initialization
  
  /// - Parameter window: UIWindow
  init(window: UIWindow) {
    self.window = window
  }
  
  // MARK: - Internal func
  
  func start() {
    let mainScreenCoordinator = MainScreenCoordinator(navigationController)
    self.coordinator = mainScreenCoordinator
    mainScreenCoordinator.start()
    
    window.overrideUserInterfaceStyle = .light
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
  }
}
