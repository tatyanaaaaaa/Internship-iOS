//
//  MainScreenFactory.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// Cобытия которые отправляем из Factory в Presenter
protocol MainScreenFactoryOutput: AnyObject {
  
  /// Контент был отсортирован от А до Я
  ///  - Parameter content: Моделька данных
  func didSortedContent(_ content: MainScreenModel)
}

/// Cобытия которые отправляем от Presenter к Factory
protocol MainScreenFactoryInput {
  
  /// Отсортировать контент от А до Я
  ///  - Parameter content: Моделька данных
  func sortContent(_ content: MainScreenModel)
}

/// Фабрика
final class MainScreenFactory: MainScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenFactoryOutput?
  
  // MARK: - Internal func
  
  func sortContent(_ content: MainScreenModel) {
    let company = MainScreenModel.Company(name: content.company.name,
                            employees: content.company.employees.sorted { $0 < $1 })
    let newContent = MainScreenModel(company: company)
    output?.didSortedContent(newContent)
  }
}

// MARK: - Appearance

private extension MainScreenFactory {
  struct Appearance {}
}
