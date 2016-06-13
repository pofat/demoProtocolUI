//
//  Weather.swift
//  testAutoLoadImageView
//
//  Created by Pofat Diuit on 2016/6/13.
//  Copyright © 2016年 duolC. All rights reserved.
//

import Foundation

class Weather: NSObject, JSONResource, Unique, StringRepresentable {
    var currentTemperature: String?
    var cityName: String?
    var updatedTime: String?
    var information: String?

    var id: String!
    
    var jsonURL: String = ""
}


extension JSONResource where Self: Weather {
    func processJSON(success: Bool) {
        if let json = self.jsonValue where success {
            self.currentTemperature = json["currentTemperature"] as? String ?? "氣溫"
            self.cityName = json["cityName"] as? String ?? "城市"
            self.updatedTime = json["jsonUpdateTime"] as? String ?? NSDate().description
            self.information = json["information"] as? String ?? "今日氣象摘要"
        }
    }
}

extension StringRepresentable where Self: Weather {
    var short: String { return String(format: "%@°C", self.currentTemperature!) }
    var medium: String { return String(format: "%@ 現在 %@°C", self.cityName!, self.currentTemperature!) }
    var long: String { return self.information! }
}