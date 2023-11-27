import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.day ?? 0
    }
    
    var month: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.month ?? 0
    }
    
    var year: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components.year ?? 0
    }
    
    var weekDay: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func firstWeekdayOfMonth() -> Int {
      let components = Calendar.current.dateComponents([.year, .month], from: self)
      let firstDayOfMonth = Calendar.current.date(from: components)!
      
      return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    func numberOfDays() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    func addMonth(month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: Date())!
    }
}
