// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let holiday = try? newJSONDecoder().decode(Holiday.self, from: jsonData)

import Foundation

// MARK: - HolidayElement
struct HolidayElement: Codable {

    let name, nameLocal, language, holidayDescription: String
    let country, location, type, date: String
    let dateYear, dateMonth, dateDay, weekDay: String

    enum CodingKeys: String, CodingKey {
        case name
        case nameLocal = "name_local"
        case language
        case holidayDescription = "description"
        case country, location, type, date
        case dateYear = "date_year"
        case dateMonth = "date_month"
        case dateDay = "date_day"
        case weekDay = "week_day"
    }
}

typealias Holiday = [HolidayElement?]

//MARK: - Struct for second API

//// MARK: - Holiday
//struct Holiday: Codable {
//    let meta: Meta
//    let response: Response
//}
//
//// MARK: - Meta
//struct Meta: Codable {
//    let code: Int
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let holidays: [HolidayElement]
//}
//
//// MARK: - HolidayElement
//struct HolidayElement: Codable {
//    let name, holidayDescription: String
//    let country: Country
//    let date: DateClass
//    let type: [String]
//    let locations: String
//    let states: StatesUnion
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case holidayDescription = "description"
//        case country, date, type, locations, states
//    }
//}
//
//// MARK: - Country
//struct Country: Codable {
//    let id: ID
//    let name: Name
//}
//
//enum ID: String, Codable {
//    case us = "us"
//}
//
//enum Name: String, Codable {
//    case unitedStates = "United States"
//}
//
//// MARK: - DateClass
//struct DateClass: Codable {
//    let iso: String
//    let datetime: Datetime
//}
//
//// MARK: - Datetime
//struct Datetime: Codable {
//    let year, month, day: Int
//}
//
//enum StatesUnion: Codable {
//    case enumeration(StatesEnum)
//    case stateArray([State])
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode([State].self) {
//            self = .stateArray(x)
//            return
//        }
//        if let x = try? container.decode(StatesEnum.self) {
//            self = .enumeration(x)
//            return
//        }
//        throw DecodingError.typeMismatch(StatesUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StatesUnion"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .enumeration(let x):
//            try container.encode(x)
//        case .stateArray(let x):
//            try container.encode(x)
//        }
//    }
//}
//
//// MARK: - State
//struct State: Codable {
//    let id: Int
//    let abbrev, name: String
//    let exception: String?
//    let iso: String
//}
//
//enum StatesEnum: String, Codable {
//    case all = "All"
//}
//
