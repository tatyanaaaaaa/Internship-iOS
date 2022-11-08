//
//  MainScreenModel.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import Foundation

struct MainScreenModel: Codable {

  /// Компания
  let company: Company
  
  // MARK: - Company
  
  struct Company: Codable {
    
    /// Имя компании
    let name: String
    
    /// Список работников
    let employees: [Employee]
  }
  
  // MARK: - Employee
  
  struct Employee: Codable {
    
    /// Имя работника
    let name: String
    
    /// Номер телефона работника
    let phoneNumber: String
    
    /// Навыки работника
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
      case name
      case phoneNumber = "phone_number"
      case skills
    }
  }
}

extension MainScreenModel.Employee: Comparable {
  static func < (lhs: MainScreenModel.Employee, rhs: MainScreenModel.Employee) -> Bool {
    lhs.name < rhs.name
  }
}
