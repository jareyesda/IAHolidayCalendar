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
