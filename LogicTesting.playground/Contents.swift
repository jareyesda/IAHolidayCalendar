import Cocoa

var greeting = "Hello, playground"

let selectedDate = Date()
var totalSquares = [String]()

class CalendarManager {
    
    let calendar = Calendar.current
    
    func addMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func subtractMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let days = calendar.range(of: .day, in: .month, for: date)!
        return days.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
}

//print(CalendarManager().firstOfMonth(date: selectedDate))
//print(CalendarManager().firstOfMonth(date: CalendarManager().addMonth(date: selectedDate)))
//print(CalendarManager().dayOfMonth(date: CalendarManager().addMonth(date: selectedDate)))
//print(CalendarManager().weekDay(date: selectedDate))

func setMonthView() {
    // Reset data
    totalSquares.removeAll()
    
    // Getting month data
    let daysInMonth = CalendarManager().daysInMonth(date: selectedDate)
    let firstDayOfMonth = CalendarManager().firstOfMonth(date: selectedDate)
    let startingSpaces = CalendarManager().weekDay(date: firstDayOfMonth)
    print(startingSpaces)
    
    var count: Int = 1
    
    // Creating array to populate calendar days
    while(count <= 42) {
        // We are using 42 because there are 42 squares in a calendar's month
        if count <= startingSpaces || count - startingSpaces > daysInMonth {
            totalSquares.append("")
        } else {
            totalSquares.append(String(count - startingSpaces))
        }
        
        count += 1
    }
    
}

setMonthView()
print(totalSquares)
print()
print(totalSquares.count)
print()
print(CalendarManager().daysInMonth(date: selectedDate))

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

var holidays = [Holiday]()

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

print(NetworkManager().parse(json: NetworkManager().fetchHolidayJSON(year: "2020", month: "1", day: "1")))

let holidayDates = ["2"]

print(totalSquares)

func getHolidayPresentArray(_ array: [String], from: [String]) -> [String] {
    var retVal = [String]()
    for square in totalSquares {
        if from.contains(square) {
            retVal.append(square)
        } else {
            retVal.append("")
        }
    }
    return retVal
}

print(getHolidayPresentArray(totalSquares, from: holidayDates))






