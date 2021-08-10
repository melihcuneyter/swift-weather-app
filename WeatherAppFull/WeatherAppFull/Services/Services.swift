//
//  Services.swift
//  WeatherAppFull
//
//  Created by Melih Cüneyter on 5.08.2021.
//

import Foundation

class Webservices {
    func downloadServices(url: URL, completion: @escaping ((RootWeather)?) ->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let weatherList = try JSONDecoder().decode(RootWeather.self, from: data)
                    completion(weatherList)
                } catch let error {
                    print("Error! ", error)
                }
            }
        }.resume()
    }
}
