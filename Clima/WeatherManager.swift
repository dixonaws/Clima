//
//  WeatherManager.swift
//  Clima
//
//  Created by John Dixon on 6/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?appid=b19a74c1a7dbf6e3af33f1a2f3fba4dc&units=metric"
    
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString="\(weatherUrl)&q=\(cityName)"
        
        performRequest(urlString: urlString)
        
    } // fetchWeather
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString="\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(urlString: urlString)
        
    } // featchWeather
    
    func performRequest(urlString: String) {
        if let url=URL(string: urlString) {
            let session=URLSession(configuration: .default)
            
            // ordinary
            // let task=session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            // with closure
            let task=session.dataTask(with: url, completionHandler: { (data, response, error) in
                if(error != nil ) {
                    print(error)
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData=data {
                    if let weather=self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                    
                    let dataString=String(data: safeData, encoding: .utf8)
                    print(dataString)
                }
                
            })
            
            task.resume()
            
        }
        
    } // performRequest
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder=JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp=decodedData.main.temp
            let description=decodedData.weather[0].description
            let name=decodedData.name
            let conditionId=decodedData.weather[0].id
            let country=decodedData.sys.country

            let weather=WeatherModel(conditionId: conditionId, cityName: name, temperature: temp, country: country)
            
            print(weather.conditionName)
            return(weather)
            
        } catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return(nil)
        }
        
    } // parseJSON
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if(error != nil ) {
            print(error)
        }
        
        if let safeData=data {
            let dataString=String(data: safeData, encoding: .utf8)

        }
        
    } // handle()
    
}

