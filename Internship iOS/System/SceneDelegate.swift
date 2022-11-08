//
//  SceneDelegate.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  // MARK: - Internal property
  
  var window: UIWindow?
  
  // MARK: - Private property
  
  private var coordinator: Coordinator?
  
  // MARK: - Internal func
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: scene)
    let coordinator = RootCoordinator(window: window)
    self.coordinator = coordinator
    coordinator.start()
    self.window = window
  }
}
