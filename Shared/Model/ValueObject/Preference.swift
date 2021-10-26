//
//  UserSetting.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/21.
//

import Foundation
struct Preference: Codable{
    let unit:BodyTemperatureUnit
    let color:ThemeColor
    let celsiusRange:CelsiusRange
}

extension Preference{
    func changeUnit(_ unit:BodyTemperatureUnit) -> Self{
        return .init(unit: unit, color: self.color, celsiusRange: self.celsiusRange)
    }
    
    func changeCelsiusRange(_ range:CelsiusRange) -> Self{
        return .init(unit: self.unit, color: self.color, celsiusRange: range)
    }
}
