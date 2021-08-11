//
//  NetworkManager.swift
//  IAHolidayCalendar
//
//  Created by Juan Reyes on 8/2/21.
//

import Foundation

struct NetworkManager {
    
    //MARK: - API 1
    let baseURL = "https://holidays.abstractapi.com/v1/?api_key=af4d66a7659e40f081ce25b8e258a9fd&country=US"
    
    // API 1)
    // Fetching holidays synchronously
    func fetchHoliday(dates: [DateModel?]) -> [Holiday?] {
        var holidays = [Holiday?]()
        for date in dates {
            if date == nil {
                holidays.append(nil)
            } else {
                let jsonData = fetchHolidayJSON(year: String(describing: date!.year), month: String(describing: date!.month), day: String(describing: date!.day))
                holidays.append(parse(json: jsonData))
            }
        }
        return holidays
    }
    
    // Fetch Data Function
    func fetchHolidayJSON(year: String, month: String, day: String) -> Data {

        // Arguments needed: &year=XXXX&month=X&day=X where X is a String(Int)
        let urlString = "\(baseURL)&year=\(year)&month=\(month)&day=\(day)"

        var dataResponse = Data()

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                dataResponse = data
            }
        }

        return dataResponse

    }

    // Parse Data Function
    func parse(json: Data) -> Holiday {

        var retVal = Holiday()

        let decoder = JSONDecoder()

        if let jsonData = try? decoder.decode(Holiday.self, from: json) {
            retVal = jsonData
        }

        return retVal

    }
    
    // Alternate API 1 Method
//    func getHolidays(year: String, month: String, day: String, completion: @escaping (Holiday?) -> Void) {
//        let baseURL = "https://holidays.abstractapi.com/v1/?api_key=b8a42ac1698449579eca97ee93f3567f&country=US&type=national"
//
//        guard let url = URL(string: "\(baseURL)&year=\(year)&month=\(month)&day=\(day)") else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            do {
//                let jsonData = try? JSONDecoder().decode(Holiday.self, from: data)
//                completion(jsonData)
//            }
//
//        }.resume()
//    }
    
    //MARK: - API 2
    // API 2)
//    func getHolidays(year: String, month: String, completion: @escaping ([HolidayElement]?) -> Void) {
//        let baseURL = "https://calendarific.com/api/v2/holidays?&api_key=922bb56cb346a191244196e78d1490591ecca70c&country=US&type=national"
//
//        guard let url = URL(string: "\(baseURL)&year=\(year)&month=\(month)") else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            do {
//                let jsonData = try? JSONDecoder().decode(Holiday.self, from: data)
//                completion(jsonData?.response.holidays)
//            }
//
//        }.resume()
//    }
    
}
