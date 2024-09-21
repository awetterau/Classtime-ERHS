//
//  eventsView.swift
//  ClassTime
//
//  Created by August Wetterau on 10/17/21.
//

import SwiftUI


struct eventsView: View {
    
    
    let firstDay = DateComponents(calendar: .current,
        year: 2024,
        month: 8,
        day: 8)
    @EnvironmentObject var gameView: GameClass
  
    @State var EventList: [Event] = [
        Event(id: 1, name: "Labor Day", date: DateComponents(calendar: .current,
                year: 2024,
                month: 9,
                day: 4)),
        Event(id: 2, name: "Non-Student Day", date: DateComponents(calendar: .current,
                year: 2024,
                month: 10,
                day: 2)),
        Event(id: 3, name: "Veterans Day", date: DateComponents(calendar: .current,
                year: 2024,
                month: 11,
                day: 16)),
        Event(id: 4, name: "Thanksgiving Break", date: DateComponents(calendar: .current,
                year: 2024,
                month: 11,
                day: 16)),
        Event(id: 5, name: "Winter Break", date: DateComponents(calendar: .current,
                year: 2024,
                month: 15,
                day: 16)),
        Event(id: 6, name: "MLK Day", date: DateComponents(calendar: .current,
                year: 2025,
                month: 1,
                day: 15)),
        Event(id: 7, name: "Lincoln's Bday", date: DateComponents(calendar: .current,
                year: 2025,
                month: 2,
                day: 12)),
        Event(id: 8, name: "Presidents' Day", date: DateComponents(calendar: .current,
                year: 2025,
                month: 2,
                day: 19)),
        Event(id: 9, name: "Spring Break", date: DateComponents(calendar: .current,
                year: 2025,
                month: 3,
                day: 30)),
        Event(id: 10, name: "Memorial Day", date: DateComponents(calendar: .current,
                year: 2025,
                month: 5,
                day: 27)),
        Event(id: 11, name: "School End", date: DateComponents(calendar: .current,
                year: 2025,
                month: 5,
                day: 31))
        
    ]

    
    
    func getDaysInMonth(month: Int, year: Int) -> Int? {
            let calendar = Calendar.current

            var startComps = DateComponents()
            startComps.day = 1
            startComps.month = month
            startComps.year = year

            var endComps = DateComponents()
            endComps.day = 1
            endComps.month = month == 12 ? 1 : month + 1
            endComps.year = month == 12 ? year + 1 : year

            
            let startDate = calendar.date(from: startComps)!
            let endDate = calendar.date(from:endComps)!

            
            let diff = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)

            return diff.day
        }
      
    public func getDaysLeft(date: DateComponents) -> Int {
        
        let calendar = Calendar.current
        let event = Calendar.current.date(from: date)!
        
        var startOfYear = DateComponents(calendar: .current,
                                     year: 2021,
                                     month: 1,
                                     day: 1)
        var monthsSinceStartOfYear = now.months(from: calendar.date(from: startOfYear)!)
        var monthsUntilEvent = event.months(from: now)
        
        var totalDays = event.days(from: now)
       
        while (monthsUntilEvent > 0) {
            
            if (monthsSinceStartOfYear >= 12) {
                monthsSinceStartOfYear = 1
                startOfYear = DateComponents(calendar: .current,
                                             year: 2022,
                                             month: 1,
                                             day: 1)
            } else {
                monthsSinceStartOfYear += 1
            }
            let numberOfDays = getDaysInMonth(month: monthsSinceStartOfYear, year: startOfYear.year!)
            totalDays -= numberOfDays!
            monthsUntilEvent -= 1
          

        }
        
        return totalDays
    }
    
    @State var now = Date()
    
    var body: some View {
        ZStack() {
            Color(hex: 0x121212).ignoresSafeArea()
            VStack() {
                HStack() {
                    
                    Text("Important Dates").font(.largeTitle).bold().padding(.leading).padding(.top)
                    Spacer()
                    Button(action: {
                        gameView.gameView.toggle()
                    }) {
                        Text("Game").foregroundColor(Color(hex: 0x121212)
                        )
                    }
                }
                
                List() {
                    ForEach (EventList) { event in
                    let date = Calendar.current.date(from: event.date)!
                    let progress = 1-date.timeIntervalSinceNow / Double(date.timeIntervalSince1970-(Calendar.current.date(from: firstDay)!).timeIntervalSince1970)
                    let dater = date.months(from: now)
                 
              
                        if (date.days(from: now) >= 0) {
                    Section() {
                        HStack() {
                        ZStack() {
                            Circle().stroke(Color(hex: 0x212121), lineWidth: 5.0)
                                .frame(width: 30, height: 30)
                                .rotationEffect(Angle(degrees: 180))
                            
                            Circle()
                                .trim(from: 0.0, to: progress)
                               
                                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color.blue)
                                .frame(width: 30, height: 30)
                                .rotationEffect(Angle(degrees: 180))
                        
                            
                        }
                        Text(event.name).bold().padding(.leading).font(.title3)
                            Spacer()
                           
                                HStack() {
                                VStack() {
                                    if (date.months(from: now) > 0) {
                                Text(String(dater)).font(.caption)
//                                    .onReceive(timer2) { time in
//
//                                   }
                                        if (date.months(from: now) == 1) {
                                        Text("Month").font(.caption2)
                                        } else {
                                            Text("Months").font(.caption2)
                                        }
                                    } else {
                                        
                                            Text(String(getDaysLeft(date: event.date))).font(.caption)
                                                 if (getDaysLeft(date: event.date) == 1) {
                                                Text("Day").font(.caption2)
                                            } else {
                                                Text("Days").font(.caption2)
                                            }
                                            
                                        
                                    }
                                }
                                    VStack() {
                                        if (date.months(from: now) > 0) {
                                        Text(String(getDaysLeft(date: event.date))).font(.caption)
                                            
                                            if (getDaysLeft(date: event.date) == 1) {
                                           Text("Day").font(.caption2)
                                       } else {
                                           Text("Days").font(.caption2)
                                       }
                                       
                                 
                                        } else {
                                            Text(String((date.hours(from: now)) - date.days(from: now) * 24)).font(.caption)
                                            if ((date.hours(from: now)) - date.days(from: now) * 24 == 1) {
                                            Text("Hour").font(.footnote).multilineTextAlignment(.center)
                                            } else {
                                                Text("Hours").font(.footnote).multilineTextAlignment(.center)
                                            }
                                            //                                    Text("Hour").font(.caption2)
                                        }
                                    }
//                                    VStack() {
//                                        Text(String((date.hours(from: now)) - date.days(from: now) * 24)).font(.caption)
//                                    Text("Hour").font(.caption2)
//
//                            }
                            
                        }
                                
                        }
                    }
                        }
                    }
                }.listStyle(InsetGroupedListStyle()).onAppear(perform: {
                    UITableView.appearance().backgroundColor = UIColor(Color(hex: 0x121212))
                  
                    
                })
                
             
                    
                
            }
            VStack() {
                Spacer()
                Rectangle().frame(width: UIScreen.main.bounds.size.width, height: 4, alignment: .center).foregroundColor(Color(hex: 0x212121))
            }
        }
        
    }
    
}


struct eventsView_Previews: PreviewProvider {
    static var previews: some View {
        eventsView()
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func month(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
extension Date {

func getDaysInMonth() -> Int{
    let calendar = Calendar.current

    let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
    let date = calendar.date(from: dateComponents)!

    let range = calendar.range(of: .day, in: .month, for: date)!
    let numDays = range.count

    return numDays
}

}
                  extension Formatter {
                      static let monthMedium: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "LLL"
                          return formatter
                      }()
                      static let hour12: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "h"
                          return formatter
                      }()
                      static let minute0x: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "mm"
                          return formatter
                      }()
                      static let amPM: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "a"
                          return formatter
                      }()
                  }
                  extension Date {
                      var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
                      var hour12:  String      { return Formatter.hour12.string(from: self) }
                      var minute0x: String     { return Formatter.minute0x.string(from: self) }
                      var amPM: String         { return Formatter.amPM.string(from: self) }
                  }
