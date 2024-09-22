//
//  Gym.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 9/21/24.
//

import Foundation

struct Gym: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var address: String
    var city: String
    var state: String
    var zipCode: String
    var phoneNumber: String?
    var website: URL?
    var latitude: Double
    var longitude: Double
    var openingHours: [DayOfWeek: OpenHours]?
    var climbingTypes: [ClimbingType]
    var amenities: [Amenity]
    var photos: [URL]?

    enum DayOfWeek: String, Codable, CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }

    struct OpenHours: Codable {
        var open: Date
        var close: Date
    }

    enum ClimbingType: String, Codable, CaseIterable {
        case bouldering, topRoping
    }

    enum Amenity: String, Codable, CaseIterable {
        case showers, lockers, cafe, lounge, parking, wifi, food, drinks, events, climbing, yoga, fitness, bootcamp, childcare
    }


}
