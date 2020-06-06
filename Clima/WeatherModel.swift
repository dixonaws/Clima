//
//  WeatherModel.swift
//  Clima
//
//  Created by John Dixon on 6/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let country:String
    
    // computed property
    var conditionName:String {
        switch(conditionId) {
        case 200...232:
            return("cloud.bolt")
        case 300...321:
            return("cloud.drizzle")
        case 500...531:
            return("cloud.heavyrain")
        case 600...622:
            return("cloud.snow")
        case 701...781:
            return("cloud.fog")
        case 800:
            return("sun.max")
        case 801...804:
            return("cloud.sun")
        default:
            return("cloud.sun")
        } // switch
    
    } // conditionName
    
    var temperatureString:String {
        return(String(format: "%.0f", temperature))

    } // temperatureString
   
} // WeatherModel
