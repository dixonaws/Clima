//
//  WeatherData.swift
//  Clima
//
//  Created by John Dixon on 6/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name:String
    let main:Main
    let weather: [Weather]
    let sys:Sys
}

struct Main: Decodable {
    let temp: Double
    
}

struct Weather: Decodable {
    let description: String
    let id:Int
}

struct Sys: Decodable {
    let country: String
}
