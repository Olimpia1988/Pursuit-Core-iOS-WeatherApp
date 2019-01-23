//
//  ClientApiWeather.swift
//  WeatherApp
//
//  Created by Olimpia on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ClientApiWeather {
    
    static func getWeather(keyword: String, completionHandler: @escaping (AppError?, [Response]?) -> Void ) {
        NetworkHelper.shared.performDataTask(endpointURLString:"http://api.aerisapi.com/forecasts/\(keyword)?client_id=PyHW5kIy44vYGeIycdxpB&client_secret=002v33INFcQiR3WCE4CJzRQYevU8N3gYvcE9hQ6O", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                                   let statusCode = httpResponse?.statusCode ?? -999
                                  completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                                   return
                            }
                            if let data = data {
                               do {
                                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                                    completionHandler(nil , weather.response)
                                    } catch {
                                    completionHandler(AppError.decodingError(error), nil)
                                }
                            }
                        }
                    }

            
      }



