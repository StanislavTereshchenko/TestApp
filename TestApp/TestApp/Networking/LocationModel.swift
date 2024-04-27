//
//  LocationModel.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//

import Foundation

struct LocationData {
    let query: String
    let status: String
    let country: String
    let countryCode: String
    let region: String
    let regionName: String
    let city: String
    let zip: String
    let latitude: Double
    let longitude: Double
    let timezone: String
    let isp: String
    let org: String
    let aas: String
    
    init?(json: [String: Any]) {
        guard let query = json["query"] as? String,
              let status = json["status"] as? String,
              let country = json["country"] as? String,
              let countryCode = json["countryCode"] as? String,
              let region = json["region"] as? String,
              let regionName = json["regionName"] as? String,
              let city = json["city"] as? String,
              let zip = json["zip"] as? String,
              let latitude = json["lat"] as? Double,
              let longitude = json["lon"] as? Double,
              let timezone = json["timezone"] as? String,
              let isp = json["isp"] as? String,
              let org = json["org"] as? String,
              let aas = json["as"] as? String
        else {
            return nil
        }
        
        self.query = query
        self.status = status
        self.country = country
        self.countryCode = countryCode
        self.region = region
        self.regionName = regionName
        self.city = city
        self.zip = zip
        self.latitude = latitude
        self.longitude = longitude
        self.timezone = timezone
        self.isp = isp
        self.org = org
        self.aas = aas
    }
}
