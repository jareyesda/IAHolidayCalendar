//
//  ViewController.swift
//  IAHolidayCalendar
//
//  Created by Juan Reyes on 8/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var calendar: UICollectionView!
    
    //MARK: - Calendar CollectionView Population Components
    // Current date (modified when month is changed)
    var selectedDate = Date()
    // Array that populates the calendar cells
    var totalSquares = [String]()
    
    // Arguments that will be passed in network call
    var datesInMonth = [DateModel?]()
    // Holidays present in the selected month
    // API 1)
    var holidays = [Holiday?]()
    // API 2)
//    var holidaysInMonth = [HolidayElement]()
//    var holidayDaysInMonth = [String]()
    
    private let dispatchQueue = DispatchQueue(label: "Network thread")
    
    //MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        setMonthView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setCellUI()
    }
    
    //MARK: - CollectioView UI Configuration
    func setCellUI() {
        let width = (calendar.frame.size.width) / 7
        let height = (calendar.frame.size.height) / 7
        
        let layout = calendar.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
    }
    //MARK: - Getting data for calendar population
    func setMonthView() {
        // Reset data
        totalSquares.removeAll()
        datesInMonth.removeAll()
        // API 1)
        holidays.removeAll()
        
        // Getting month data
        let daysInMonth = CalendarManager().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarManager().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarManager().weekDay(date: firstDayOfMonth)
        
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
        //MARK: - Creating an array of dates from the current month
        // The array created here will contain the arguments that will be passed to our web API
        for i in 0...(totalSquares.count - 1) {
            if totalSquares[i] != "" {
                
                datesInMonth.append(
                    DateModel(
                        year: CalendarManager().yearString(date: self.selectedDate),
                        month: CalendarManager().monthNumber(date: self.selectedDate),
                        day: totalSquares[i]
                    )
                )
                
            } else {
                datesInMonth.append(nil)
            }
        }
        
        //MARK: - Creating an array of holidays from the current month
        // API 1)
        
        //MARK: - Original method
//        for date in datesInMonth {
//            if date == nil {
//                holidays.append(nil)
//            } else {
//                let jsonData = NetworkManager().fetchHolidayJSON(year: date!.year, month: date!.month, day: date!.day)
//                holidays.append(NetworkManager().parse(json: jsonData))
//            }
//        }
        
        //MARK: - Original method + Async network call
        for date in datesInMonth {
            if date == nil {
                holidays.append(nil)
            } else {
                dispatchQueue.async {
                    let jsonData = NetworkManager().fetchHolidayJSON(year: date!.year, month: date!.month, day: date!.day)
                    self.holidays.append(NetworkManager().parse(json: jsonData))
                }
            }
        }
        
        //MARK: - New function performed asynchronously
//        dispatchQueue.async { [self] in
//            holidays = NetworkManager().fetchHoliday(dates: datesInMonth)
//        }
                
        // Alternate for API 1 that was iffy...
//        for date in datesInMonth {
//            if date == nil {
//                holidays.append(nil)
//            } else {
//                NetworkManager().getHolidays(year: date!.year, month: date!.month, day: date!.day) { holiday in
//                    print("\(String(describing: date)) ---> \(String(describing: holiday))")
//                    self.holidays.append(holiday)
//                }
//            }
//        }
        
        // API 2)
//        NetworkManager().getHolidays(year: (CalendarManager().yearNumber(date: self.selectedDate)), month: CalendarManager().monthNumber(date: self.selectedDate)) { [self] (holidays) in
//            print("Current selected month is: \(CalendarManager().monthNumber(date: self.selectedDate))")
//            var retVal = [String]()
//            if let holidays = holidays {
//                holidaysInMonth = holidays
//                print("Holidays in the month are: \(holidaysInMonth)")
//                for holiday in holidays {
//                    retVal.append(String(holiday.date.datetime.day))
//                }
//                holidayDaysInMonth = retVal
//            }
//        }
        
        //MARK: - Events on function completion
        monthLabel.text = CalendarManager().monthString(date: selectedDate) + " " + CalendarManager().yearString(date: selectedDate)
        print(holidays)
        calendar.reloadData()
        
    }
    
    //MARK: - View next month button
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarManager().addMonth(date: selectedDate)
        setMonthView()
    }
    
    //MARK: - View previous month button
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarManager().subtractMonth(date: selectedDate)
        setMonthView()
    }
    
}

//MARK: - Collection View Delegate Methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        
        cell.dayLabel.text = totalSquares[indexPath.row]
        
        // API 1)
//        if (holidays[indexPath.row]?.count != 0 && cell.dayLabel.text != "") {
//            cell.backgroundColor = .red
//        } else {
//            cell.backgroundColor = .white
//        }
    
        
        // API 2)
//        if holidayDaysInMonth.contains(totalSquares[indexPath.row]) {
//            cell.dayLabel.text = totalSquares[indexPath.row]
//            cell.backgroundColor = .red
//        } else {
//            cell.dayLabel.text = totalSquares[indexPath.row]
//            cell.backgroundColor = .white
//
//        }
//
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(holidays)
        // API 1)
//        if holidays[indexPath.item]?.count != 0 {
//            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
//                vc.name = String(holidays[indexPath.item]![0]!.name)
//
//                navigationController?.pushViewController(vc, animated: true)
//            }
//        }
    }
    
}

