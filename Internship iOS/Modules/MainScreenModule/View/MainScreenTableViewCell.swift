//
//  MainScreenTableViewCell.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import UIKit

final class MainScreenTableViewCell: UITableViewCell {
  
  // MARK: - Internal property
  
  /// Identifier для ячейки
  static let reuseIdentifier = MainScreenTableViewCell.description()
  
  // MARK: - Private property
  
  private let nameLabel = UILabel()
  private let phoneLabel = UILabel()
  private let skillsLabel = UILabel()
  
  // MARK: - Initilisation
  
  override init(style: CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Internal func
  
  /// Настраиваем ячейку
  /// - Parameters:
  ///  - name: Имя
  ///  - phone: Телефон
  ///  - skills: Навыки
  func configureCellWith(name: String?, phone: String?, skills: [String]) {
    let appearance = Appearance()
    
    if let name = name {
      nameLabel.text = appearance.name + name
    }
    
    if let phone = phone {
      phoneLabel.text = appearance.phone + phone
    }
    
    if !skills.isEmpty {
      skillsLabel.text = appearance.skills + skills.joined(separator:", ")
    }
  }
  
  // MARK: - Private func
  
  private func configureLayout() {
    let appearance = Appearance()
    
    [nameLabel, phoneLabel, skillsLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                         constant: appearance.insets.left),
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                     constant: appearance.insets.top),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                          constant: -appearance.insets.right),
      
      phoneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                          constant: appearance.insets.left),
      phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                      constant: appearance.insets.top),
      phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                           constant: -appearance.insets.right),
      
      skillsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: appearance.insets.left),
      skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor,
                                       constant: appearance.insets.top),
      skillsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -appearance.insets.right),
      skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -appearance.insets.bottom)
    ])
  }
  
  private func applyDefaultBehavior() {
    backgroundColor = .white
    selectionStyle = .none
    
    nameLabel.numberOfLines = .zero
    phoneLabel.numberOfLines = .zero
    skillsLabel.numberOfLines = .zero
  }
}

// MARK: - Appearance

private extension MainScreenTableViewCell {
  struct Appearance {
    let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    let name = "Name: "
    let phone = "Phone: "
    let skills = "Skills: "
  }
}
