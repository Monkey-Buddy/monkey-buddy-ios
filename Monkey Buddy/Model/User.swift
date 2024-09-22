//
//  User.swift
//  Monkey Buddy
//
//  Created by Gavin Lang on 9/18/24.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: UUID
    var username: String
    var profileImageUrl: URL?
    var bio: String?
    var height: Height?
    var weight: Weight?
    var boulderingLevel: BoulderingLevel
    var topRopeLevel: TopRopeLevel
    var climbingSchedule: ClimbingSchedule
    var friends: [FriendReference]?
    var primaryGym: String?
    var savedGyms: [GymReference]?
    var isPrivateAccount: Bool

    enum BoulderingLevel: String, Codable, CaseIterable {
        case beginner = "V0-V1"
        case novice = "V2-V3"
        case intermediate = "V4-V5"
        case advanced = "V6-V7"
        case expert = "V8-V9"
        case elite = "V10-V11"
        case master = "V12-V13"
        case professional = "V14-V15"
        case worldClass = "V16+"
        
        var description: String {
            "\(String(describing: self).capitalized) - \(rawValue == "V16+" ? "World Class" : self.rawValue)"
        }

        var range: ClosedRange<Int> {
            switch self {
            case .beginner: return 0...1
            case .novice: return 2...3
            case .intermediate: return 4...5
            case .advanced: return 6...7
            case .expert: return 8...9
            case .elite: return 10...11
            case .master: return 12...13
            case .professional: return 14...15
            case .worldClass: return 16...17
            }
        }

        init(grade: Int) {
            self = Self.allCases.first { $0.range.contains(grade) } ?? .beginner
        }
    }

    enum TopRopeLevel: String, Codable, CaseIterable, CustomStringConvertible {
        case beginner = "5.2-5.5"
        case novice = "5.6-5.8"
        case intermediate = "5.9-5.10"
        case advanced = "5.11-5.12a"
        case expert = "5.12b-5.13a"
        case elite = "5.13b-5.14a"
        case master = "5.14b-5.14d"
        case worldClass = "5.15+"
        
        var description: String {
            "\(String(describing: self).capitalized) - \(rawValue == "5.15+" ? "World Class" : self.rawValue)"
        }
        
        var range: ClosedRange<Double> {
            switch self {
            case .beginner: return 5.2...5.5
            case .novice: return 5.6...5.8
            case .intermediate: return 5.9...5.10
            case .advanced: return 5.11...5.12
            case .expert: return 5.12...5.13
            case .elite: return 5.13...5.14
            case .master: return 5.14...5.14
            case .worldClass: return 5.15...5.15 // Upper bound is inclusive
            }
        }
        
        init(grade: Double) {
            let roundedGrade = (grade * 10).rounded() / 10 // Round to nearest 0.1
            self = Self.allCases.first { $0.range.contains(roundedGrade) } ?? .beginner
        }
    }

    struct ClimbingSchedule: Hashable, Codable {
        var monday: [Range<Date>]
        var tuesday: [Range<Date>]
        var wednesday: [Range<Date>]
        var thursday: [Range<Date>]
        var friday: [Range<Date>]
        var saturday: [Range<Date>]
        var sunday: [Range<Date>]
    }

    struct FriendReference: Hashable, Codable {
        let id: UUID
        var username: String
        var boulderlevel: BoulderingLevel
        var topRopeLevel: TopRopeLevel
    }
    
    struct GymReference: Hashable, Codable {
        let id: UUID
        var name: String
        var gymImage: URL?
    }

    struct Height: Hashable, Codable {
        var value: Double
        var unit: HeightUnit

        enum HeightUnit: String, Codable {
            case centimeters
            case inches
        }
    }

    struct Weight: Hashable, Codable {
        var value: Double
        var unit: WeightUnit

        enum WeightUnit: String, Codable {
            case kilograms
            case pounds
        }
    }
}

// Haversine formula to calculate distance between two points on a sphere
func distance(from user1: User, to user2: User) -> Double {
    let earthRadius = 6371.0 // in kilometers
    let dLat = (user2.latitude - user1.latitude) * .pi / 180
    let dLong = (user2.longitude - user1.longitude) * .pi / 180

    let lat1 = user1.latitude * .pi / 180
    let lat2 = user2.latitude * .pi / 180

    let a = sin(dLat / 2) * sin(dLat / 2) + (cos(lat1) * cos(lat2) * sin(dLong / 2) * sin(dLong / 2))
    let c = 2 * asin(sqrt(a))
    return earthRadius * c
}

func findNearbyUsers(from user: User, to users: [User]) -> [UserReference] {
    return users.filter { distance(from user, to: $0) <= maxDistance } 
}