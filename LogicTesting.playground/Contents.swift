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
