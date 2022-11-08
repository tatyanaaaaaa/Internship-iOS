//
//  MainScreenView.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

/// События которые отправляем из View в Presenter
protocol MainScreenViewOutput: AnyObject {}

/// События которые отправляем от Presenter ко View
protocol MainScreenViewInput: AnyObject {
  
  /// Запустить лоадер
  func startloaderLoader()
  
  /// Остановить лоадер
  func stoploaderLoader()
  
  /// Обновить контент
  ///  - Parameter models: Массив моделек
  func updateContentWith(models: [MainScreenModel.Employee])
}

/// Псевдоним протокола UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View для экрана
final class MainScreenView: MainScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties
  
  private let tableView = UITableView()
  private let loaderView = UIActivityIndicatorView()
  private var models: [MainScreenModel.Employee] = []
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal func
  
  func updateContentWith(models: [MainScreenModel.Employee]) {
    self.models = models
    tableView.reloadData()
  }
  
  func startloaderLoader() {
    loaderView.isHidden = false
    loaderView.startAnimating()
  }
  
  func stoploaderLoader() {
    loaderView.isHidden = true
    loaderView.stopAnimating()
  }
}

// MARK: - UITableViewDelegate

extension MainScreenView: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MainScreenView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    var viewCell = UITableViewCell()
    
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: MainScreenTableViewCell.reuseIdentifier
    ) as? MainScreenTableViewCell {
      cell.configureCellWith(name: model.name,
                             phone: model.phoneNumber,
                             skills: model.skills)
      viewCell = cell
    }
    return viewCell
  }
}

// MARK: - Private

private extension MainScreenView {
  func configureLayout() {
    [tableView, loaderView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
      loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  func applyDefaultBehavior() {
    backgroundColor = .white
    tableView.backgroundColor = .white
    
    loaderView.isHidden = true
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(MainScreenTableViewCell.self,
                       forCellReuseIdentifier: MainScreenTableViewCell.reuseIdentifier)
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {
    let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
}
