//
//  Converter.swift
//  Project2
//
//  Created by Jinwoo Kim on 2/22/21.
//

import Foundation

struct Converter {
    func convertToCelsius(fahrenheit: Double) -> Double {
//        return (fahrenheit - 32) * 5 / 9
        let fahrenheit = Measurement(value: fahrenheit, unit: UnitTemperature.fahrenheit)
        let celsius = fahrenheit.converted(to: UnitTemperature.celsius)
        return celsius.value
    }
}
