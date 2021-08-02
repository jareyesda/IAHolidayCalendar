//
//  NetworkManager.swift
//  IAHolidayCalendar
//
//  Created by Juan Reyes on 8/2/21.
//

import Foundation

struct NetworkManager {
    
    let baseURL = "https://holidays.abstractapi.com/v1/?api_key=b8a42ac1698449579eca97ee93f3567f&country=US"
    
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
    
}
