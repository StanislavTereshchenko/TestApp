//
//  RealmModel.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//
import RealmSwift
import Foundation

class LocationDataObject: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var query: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var countryCode: String = ""
    @objc dynamic var region: String = ""
    @objc dynamic var regionName: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zip: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timezone: String = ""
    @objc dynamic var isp: String = ""
    @objc dynamic var org: String = ""
    @objc dynamic var aas: String = ""
    
    override static func primaryKey() -> String? {
            return "id" 
        }
    
    convenience init(_ locationData: LocationData) {
        self.init()
        self.query = locationData.query
        self.status = locationData.status
        self.country = locationData.country
        self.countryCode = locationData.countryCode
        self.region = locationData.region
        self.regionName = locationData.regionName
        self.city = locationData.city
        self.zip = locationData.zip
        self.latitude = locationData.latitude
        self.longitude = locationData.longitude
        self.timezone = locationData.timezone
        self.isp = locationData.isp
        self.org = locationData.org
        self.aas = locationData.aas
    }
}
