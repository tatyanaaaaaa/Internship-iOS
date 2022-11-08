//
//  NetworkError.swift
//  Internship iOS
//
//  Created by Tatyana Sosina on 08.11.2022.
//

import Foundation

/// Сетевая ошибка
enum NetworkError: Error {
  
  /// Подключение к Интернету отсутствует
  case noInternetConnection
  
  /// Неверный URL-запрос
  case invalidURLRequest
  
  /// Неприемлемый код состояния HTTP
  case unacceptedHTTPStatus(code: Int)
  
  /// Непредвиденный ответ сервера
  case unexpectedServerResponse
}
