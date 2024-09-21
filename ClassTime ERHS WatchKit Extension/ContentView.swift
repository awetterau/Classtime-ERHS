//
//  ContentView.swift
//  ClassTime ERHS WatchKit Extension
//
//  Created by August Wetterau on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentDate = Date()
    @State var name = ""
    @State public var now = Date()
    @State var yes = true
    @State var cpText = "You are not in school hours"
    @State var timeText = "00:00"
    @State var currentPer = "One"
    @State var timeSinceClassStarted = 0.0
    @State var timeUntilNextClass = 0.0
    @State var timeWhenClassEnds = 0.0
    @State var progress: CGFloat = 0.0
    @State private var isCommonDay: Bool = false

    @State private var animationShowing = false
    @State private var firstLunchOdd: Bool  = true
    @State private var firstLunchEven: Bool = true
    @State private var timeRemaining = 100
    @State var numOfUpcoming = 0
    

    
    private let defaults = UserDefaults.standard
    
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer3 = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
  
    func save() {
        
       
       
        defaults.set(firstLunchOdd, forKey: "Lunch Odd")
        defaults.set(firstLunchEven,forKey: "Lunch Even")

        
        

  
        
    }
    func load(){
        

        let savedLunchOdd = defaults.bool(forKey: "Lunch Odd")
        let savedLunchEven = defaults.bool(forKey: "Lunch Even")
   
        
       
    
        firstLunchOdd = savedLunchOdd
        firstLunchEven = savedLunchEven
    }
    
    
    func checkTime() {
            now = Date()
            let calendar = Calendar.current
        
        
        if (isCommonDay) {
            let perOne = calendar.date(
                bySettingHour: 8,
                minute: 30,
                second: 13,
                of: now)!
            let pp1 = calendar.date(
                bySettingHour: 9,
                minute: 27,
                second: 13,
                of: now)!
        
            let perTwo = calendar.date(
                bySettingHour: 9,
                minute: 35,
                second: 13,
                of: now)!
            let pp2 = calendar.date(
                bySettingHour: 10,
                minute: 32,
                second: 13,
                of: now)!
        
            let perThree = calendar.date(
                bySettingHour: 10,
                minute: 40,
                second: 13,
                of: now)!
            let lunchStart = calendar.date(
                bySettingHour: 11,
                minute: 38,
                second: 13,
                of: now)!
            let lunchEnd = calendar.date(
                bySettingHour: 12,
                minute: 18,
                second: 13,
                of: now)!
            let secondLunchStart = calendar.date(
                bySettingHour: 12,
                minute: 44,
                second: 13,
                of: now)!
            let secondLunchEnd = calendar.date(
                bySettingHour: 13,
                minute: 24,
                second: 13,
                of: now)!
            let perFour2 = calendar.date(
                bySettingHour: 11,
                minute: 46,
                second: 13,
                of: now)!
        
            let perFour = calendar.date(
                bySettingHour: 12,
                minute: 26,
                second: 13,
                of: now)!
            let pp4 = calendar.date(
                bySettingHour: 13,
                minute: 24,
                second: 13,
                of: now)!
        
            let perFive = calendar.date(
                bySettingHour: 13,
                minute: 32,
                second: 13,
                of: now)!
            let pp5 = calendar.date(
                bySettingHour: 14,
                minute: 30,
                second: 13,
                of: now)!
        
            let perSix = calendar.date(
                bySettingHour: 14,
                minute: 38,
                second: 13,
                of: now)!
        
            let schoolEnd = calendar.date(
                bySettingHour: 15,
                minute: 36,
                second: 13,
                of: now)!
            
            if now >= perOne &&
              now <= pp1
         {
                cpText = "Period One"
                timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
                
                timeUntilNextClass = pp1.timeIntervalSinceNow
            } else if now >= pp1 &&
                        now <= perTwo {
                cpText = "Passing Period"
                timeText = (String(Int(perTwo.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perTwo.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perTwo.timeIntervalSince1970-pp1.timeIntervalSince1970)
                
                timeUntilNextClass = perTwo.timeIntervalSinceNow
            } else if now >= perTwo &&
                        now <= pp2 {
                cpText = "Period Two"
                timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp2.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                
                timeUntilNextClass = pp2.timeIntervalSinceNow
            } else if now >= pp2 &&
                        now <= perThree {
                cpText = "Passing Period"
                timeText = (String(Int(perThree.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perThree.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perThree.timeIntervalSince1970-pp2.timeIntervalSince1970)
                
                timeUntilNextClass = perThree.timeIntervalSinceNow
            } else if now >= perThree &&
                        now <= lunchStart {
                cpText = "Period Three"
                timeText = (String(Int(lunchStart.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(lunchStart.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(lunchStart.timeIntervalSince1970-perThree.timeIntervalSince1970)
                
                timeUntilNextClass = lunchStart.timeIntervalSinceNow
            } else if now >= lunchStart &&
                        now <= lunchEnd {
                cpText = "Lunch"
                timeText = (String(Int(lunchEnd.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(lunchEnd.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(lunchEnd.timeIntervalSince1970-lunchStart.timeIntervalSince1970)
                
                timeUntilNextClass = lunchEnd.timeIntervalSinceNow
            } else if now >= lunchEnd &&
                        now <= perFour {
                cpText = "Passing Period"
                timeText = (String(Int(perFour.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perFour.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perFour.timeIntervalSince1970-lunchEnd.timeIntervalSince1970)
                
                timeUntilNextClass = perFour.timeIntervalSinceNow
            } else if now >= perFour &&
                        now <= pp4 {
                cpText = "Fourth Period"
                timeText = (String(Int(pp4.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp4.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp4.timeIntervalSince1970-perFour.timeIntervalSince1970)
                
                timeUntilNextClass = pp4.timeIntervalSinceNow
            } else if now >= pp4 &&
                        now <= perFive {
                cpText = "Passing Period"
                timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perFive.timeIntervalSince1970-pp4.timeIntervalSince1970)
                
                timeUntilNextClass = perFive.timeIntervalSinceNow
            } else if now >= perFive &&
                        now <= pp5 {
                cpText = "Period Five"
                timeText = (String(Int(pp5.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp5.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp5.timeIntervalSince1970-perFive.timeIntervalSince1970)
                
                timeUntilNextClass = pp5.timeIntervalSinceNow
            } else if now >= pp5 &&
                        now <= perSix {
                cpText = "Passing Period"
                timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp5.timeIntervalSince1970)
                
                timeUntilNextClass = perSix.timeIntervalSinceNow
            } else if now >= perSix &&
                        now <= schoolEnd {
                cpText = "Period Six"
                timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
                timeUntilNextClass = schoolEnd.timeIntervalSinceNow
            } else {
                cpText = "You are not in school hours"
                progress = 0
                timeText = "00:00"
            }
            
            if cpText != "You are not in school hours" {
                if !((timeUntilNextClass) <= 1) {
            progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                } else {
                    
                    if !animationShowing {
                        animationShowing = true
                        timeRemaining = 100
                        
                    }
                }
            }
        }  else if now.dayOfWeek() == "Monday" {
            
            let perOne = calendar.date(
                bySettingHour: 8,
                minute: 30,
                second: 13,
                of: now)!
            let pp1 = calendar.date(
                bySettingHour: 10,
                minute: 31,
                second: 13,
                of: now)!

            let perThree1 = calendar.date(
                bySettingHour: 10,
                minute: 39,
                second: 13,
                of: now)!
            let perThree = calendar.date(
                bySettingHour: 10,
                minute: 39,
                second: 13,
                of: now)!
            let secondLunchStart = calendar.date(
                bySettingHour: 12,
                minute: 47,
                second: 13,
                of: now)!
            let secondLunchEnd = calendar.date(
                bySettingHour: 13,
                minute: 27,
                second: 13,
                of: now)!
            let firstLunchStart = calendar.date(
                bySettingHour: 11,
                minute: 39,
                second: 13,
                of: now)!
            let firstLunchEnd = calendar.date(
                bySettingHour: 12,
                minute: 19,
                second: 13,
                of: now)!
            let perThree2 = calendar.date(
                bySettingHour: 12,
                minute: 27,
                second: 13,
                of: now)!
            let pp3 = calendar.date(
                bySettingHour: 13,
                minute: 27,
                second: 13,
                of: now)!

            let perFive = calendar.date(
                bySettingHour: 13,
                minute: 35,
                second: 13,
                of: now)!
            let schoolEnd = calendar.date(
                bySettingHour: 15,
                minute: 36,
                second: 13,
                of: now)!
        
            if firstLunchOdd {
            
            if now >= perOne &&
              now <= pp1
         {
                cpText = "Period One"
                timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
                
                timeUntilNextClass = pp1.timeIntervalSinceNow
            } else if now >= pp1 &&
                        now <= perThree1 {
                cpText = "Passing Period"
                timeText = (String(Int(perThree1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perThree1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perThree1.timeIntervalSince1970-pp1.timeIntervalSince1970)
                
                timeUntilNextClass = perThree1.timeIntervalSinceNow
        } else if now >= perThree1 &&
                    now <= firstLunchStart {
            cpText = "Period Three"
            timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perThree1.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchStart.timeIntervalSinceNow

        } else if now >= firstLunchStart &&
                    now <= firstLunchEnd {
            cpText = "Lunch"
            timeText = (String(Int(firstLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchEnd.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchEnd.timeIntervalSinceNow
            
        } else if now >= firstLunchEnd &&
                    now <= perThree2 {
            cpText = "Passing Period"
            timeText = (String(Int(perThree2.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perThree2.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perThree2.timeIntervalSince1970-firstLunchEnd.timeIntervalSince1970)
            
            timeUntilNextClass = perThree2.timeIntervalSinceNow
            
        } else if now >= perThree2 &&
                    now <= pp3 {
            cpText = "Period Three"
            timeText = (String(Int(pp3.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp3.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp3.timeIntervalSince1970-perThree2.timeIntervalSince1970)
            
            timeUntilNextClass = pp3.timeIntervalSinceNow
        } else if now >= pp3 &&
                    now <= perFive {
            cpText = "Passing Period"
            timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFive.timeIntervalSince1970-pp3.timeIntervalSince1970)
            
            timeUntilNextClass = perFive.timeIntervalSinceNow
            
        } else if now >= perFive &&
                    now <= schoolEnd {
            cpText = "Fifth Period"
            timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perFive.timeIntervalSince1970)
            
            timeUntilNextClass = schoolEnd.timeIntervalSinceNow

        } else {
            cpText = "You are not in school hours"
            progress = 0
            timeText = "00:00"
        }
            
            if cpText != "You are not in school hours" {
                if !((timeUntilNextClass) <= 1) {
            progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                } else {
                    
                    if !animationShowing {
                        animationShowing = true
                        timeRemaining = 100
                        
                    }
                
            }
        }
            }  else {
                if now >= perOne &&
                        now <= pp1
                   {
                          cpText = "Period One"
                          timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                          timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                          timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
                          
                          timeUntilNextClass = pp1.timeIntervalSinceNow
                      } else if now >= pp1 &&
                                  now <= perThree {
                          cpText = "Passing Period"
                          timeText = (String(Int(perThree.timeIntervalSinceNow+0.5)/60)+":")
                          timeText += String(format: "%02d", Int(perThree.timeIntervalSinceNow+0.5)%60)
                          timeWhenClassEnds = Double(perThree.timeIntervalSince1970-pp1.timeIntervalSince1970)
                          
                          timeUntilNextClass = perThree.timeIntervalSinceNow
                  } else if now >= perThree &&
                              now <= secondLunchStart {
                      cpText = "Period Three"
                      timeText = (String(Int(secondLunchStart.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(secondLunchStart.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(secondLunchStart.timeIntervalSince1970-perThree.timeIntervalSince1970)
                      
                      timeUntilNextClass = secondLunchStart.timeIntervalSinceNow

                  } else if now >= secondLunchStart &&
                              now <= secondLunchEnd {
                      cpText = "Lunch"
                      timeText = (String(Int(secondLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(secondLunchEnd.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(secondLunchEnd.timeIntervalSince1970-secondLunchStart.timeIntervalSince1970)
                      
                      timeUntilNextClass = secondLunchEnd.timeIntervalSinceNow
                      
                  } else if now >= secondLunchEnd &&
                              now <= perFive {
                      cpText = "Passing Period"
                      timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(perFive.timeIntervalSince1970-secondLunchEnd.timeIntervalSince1970)
                      
                      timeUntilNextClass = perFive.timeIntervalSinceNow
                      
                  } else if now >= perFive &&
                              now <= schoolEnd {
                      cpText = "Fifth Period"
                      timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perFive.timeIntervalSince1970)
                      
                      timeUntilNextClass = schoolEnd.timeIntervalSinceNow

                  } else {
                      cpText = "You are not in school hours"
                      progress = 0
                      timeText = "00:00"
                  }
                      
                      if cpText != "You are not in school hours" {
                          if !((timeUntilNextClass) <= 1) {
                      progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                          } else {
                              
                              if !animationShowing {
                                  animationShowing = true
                                  timeRemaining = 100
                                  
                              }
                          
                      }
                      }
                  }
        } else if now.dayOfWeek() == "Tuesday" {
            
            let perTwo = calendar.date(
                bySettingHour: 8,
                minute: 30,
                second: 13,
                of: now)!
            let pp1 = calendar.date(
                bySettingHour: 10,
                minute: 31,
                second: 13,
                of: now)!

            let perFour1 = calendar.date(
                bySettingHour: 10,
                minute: 39,
                second: 13,
                of: now)!
            let perFour = calendar.date(
                bySettingHour: 10,
                minute: 39,
                second: 13,
                of: now)!
            let secondLunchStart = calendar.date(
                bySettingHour: 12,
                minute: 47,
                second: 13,
                of: now)!
            let secondLunchEnd = calendar.date(
                bySettingHour: 13,
                minute: 27,
                second: 13,
                of: now)!
            let firstLunchStart = calendar.date(
                bySettingHour: 11,
                minute: 39,
                second: 13,
                of: now)!
            let firstLunchEnd = calendar.date(
                bySettingHour: 12,
                minute: 19,
                second: 13,
                of: now)!
            let perFour2 = calendar.date(
                bySettingHour: 12,
                minute: 27,
                second: 13,
                of: now)!
            let pp3 = calendar.date(
                bySettingHour: 13,
                minute: 27,
                second: 13,
                of: now)!

            let perSix = calendar.date(
                bySettingHour: 13,
                minute: 35,
                second: 13,
                of: now)!
            let schoolEnd = calendar.date(
                bySettingHour: 15,
                minute: 36,
                second: 13,
                of: now)!

            if firstLunchEven {
            
            if now >= perTwo &&
              now <= pp1
         {
                cpText = "Period Two"
                timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                
                timeUntilNextClass = pp1.timeIntervalSinceNow
            } else if now >= pp1 &&
                        now <= perFour1 {
                cpText = "Passing Period"
                timeText = (String(Int(perFour1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perFour1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perFour1.timeIntervalSince1970-pp1.timeIntervalSince1970)
                
                timeUntilNextClass = perFour1.timeIntervalSinceNow
        } else if now >= perFour1 &&
                    now <= firstLunchStart {
            cpText = "Period Four"
            timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perFour1.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchStart.timeIntervalSinceNow

        } else if now >= firstLunchStart &&
                    now <= firstLunchEnd {
            cpText = "Lunch"
            timeText = (String(Int(firstLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchEnd.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchEnd.timeIntervalSinceNow
            
        } else if now >= firstLunchEnd &&
                    now <= perFour2 {
            cpText = "Passing Period"
            timeText = (String(Int(perFour2.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFour2.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFour2.timeIntervalSince1970-firstLunchEnd.timeIntervalSince1970)
            
            timeUntilNextClass = perFour2.timeIntervalSinceNow
            
        } else if now >= perFour2 &&
                    now <= pp3 {
            cpText = "Period Four"
            timeText = (String(Int(pp3.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp3.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp3.timeIntervalSince1970-perFour2.timeIntervalSince1970)
            
            timeUntilNextClass = pp3.timeIntervalSinceNow
        } else if now >= pp3 &&
                    now <= perSix {
            cpText = "Passing Period"
            timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp3.timeIntervalSince1970)
            
            timeUntilNextClass = perSix.timeIntervalSinceNow
            
        } else if now >= perSix &&
                    now <= schoolEnd {
            cpText = "Fifth Period"
            timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
            
            timeUntilNextClass = schoolEnd.timeIntervalSinceNow

        } else {
            cpText = "You are not in school hours"
            progress = 0
            timeText = "00:00"
        }
            
            if cpText != "You are not in school hours" {
                if !((timeUntilNextClass) <= 1) {
            progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                } else {
                    
                    if !animationShowing {
                        animationShowing = true
                        timeRemaining = 100
                        
                    }
                
            }
        }
            }  else {
                if now >= perTwo &&
                        now <= pp1
                   {
                          cpText = "Period Two"
                          timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                          timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                          timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                          
                          timeUntilNextClass = pp1.timeIntervalSinceNow
                      } else if now >= pp1 &&
                                  now <= perFour {
                          cpText = "Passing Period"
                          timeText = (String(Int(perFour.timeIntervalSinceNow+0.5)/60)+":")
                          timeText += String(format: "%02d", Int(perFour.timeIntervalSinceNow+0.5)%60)
                          timeWhenClassEnds = Double(perFour.timeIntervalSince1970-pp1.timeIntervalSince1970)
                          
                          timeUntilNextClass = perFour.timeIntervalSinceNow
                  } else if now >= perFour &&
                              now <= secondLunchStart {
                      cpText = "Period Four"
                      timeText = (String(Int(secondLunchStart.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(secondLunchStart.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(secondLunchStart.timeIntervalSince1970-perFour.timeIntervalSince1970)
                      
                      timeUntilNextClass = secondLunchStart.timeIntervalSinceNow

                  } else if now >= secondLunchStart &&
                              now <= secondLunchEnd {
                      cpText = "Lunch"
                      timeText = (String(Int(secondLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(secondLunchEnd.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(secondLunchEnd.timeIntervalSince1970-secondLunchStart.timeIntervalSince1970)
                      
                      timeUntilNextClass = secondLunchEnd.timeIntervalSinceNow
                      
                  } else if now >= secondLunchEnd &&
                              now <= perSix {
                      cpText = "Passing Period"
                      timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(perSix.timeIntervalSince1970-secondLunchEnd.timeIntervalSince1970)
                      
                      timeUntilNextClass = perSix.timeIntervalSinceNow
                      
                  } else if now >= perSix &&
                              now <= schoolEnd {
                      cpText = "Sixth Period"
                      timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
                      timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
                      timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
                      
                      timeUntilNextClass = schoolEnd.timeIntervalSinceNow

                  } else {
                      cpText = "You are not in school hours"
                      progress = 0
                      timeText = "00:00"
                  }
                      
                      if cpText != "You are not in school hours" {
                          if !((timeUntilNextClass) <= 1) {
                      progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                          } else {
                              
                              if !animationShowing {
                                  animationShowing = true
                                  timeRemaining = 100
                                  
                              }
                          
                      }
                      }
                  }
        } else if now.dayOfWeek() == "Wednesday" {
            let perOne = calendar.date(
                bySettingHour: 9,
                minute: 50,
                second: 13,
                of: now)!
            let pp1 = calendar.date(
                bySettingHour: 10,
                minute: 35,
                second: 13,
                of: now)!

            let perTwo = calendar.date(
                bySettingHour: 10,
                minute: 43,
                second: 13,
                of: now)!
            let pp2 = calendar.date(
                bySettingHour: 11,
                minute: 28,
                second: 13,
                of: now)!

            let perThree = calendar.date(
                bySettingHour: 11,
                minute: 36,
                second: 13,
                of: now)!
            let firstLunchStart = calendar.date(
                bySettingHour: 12,
                minute: 20,
                second: 13,
                of: now)!
            let firstLunchEnd = calendar.date(
                bySettingHour: 13,
                minute: 00,
                second: 13,
                of: now)!
            let secondLunchStart = calendar.date(
                bySettingHour: 13,
                minute: 12,
                second: 13,
                of: now)!
            let secondLunchEnd = calendar.date(
                bySettingHour: 13,
                minute: 52,
                second: 13,
                of: now)!
            let perFour1 = calendar.date(
                bySettingHour: 12,
                minute: 28,
                second: 13,
                of: now)!

            let perFour = calendar.date(
                bySettingHour: 13,
                minute: 08,
                second: 13,
                of: now)!
            let pp4 = calendar.date(
                bySettingHour: 13,
                minute: 52,
                second: 13,
                of: now)!

            let perFive = calendar.date(
                bySettingHour: 14,
                minute: 00,
                second: 13,
                of: now)!
            let pp5 = calendar.date(
                bySettingHour: 14,
                minute: 45,
                second: 13,
                of: now)!

            let perSix = calendar.date(
                bySettingHour: 14,
                minute: 52,
                second: 13,
                of: now)!

            let schoolEnd = calendar.date(
                bySettingHour: 15,
                minute: 36,
                second: 13,
                of: now)!


            if firstLunchEven {
        if now >= perOne &&
            now <= pp1
        {
            cpText = "Period One"
            timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
            timeUntilNextClass = pp1.timeIntervalSinceNow
            
        } else if now >= pp1 &&
                    now <= perTwo {
            cpText = "Passing Period"
            timeText = (String(Int(perTwo.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perTwo.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perTwo.timeIntervalSince1970-pp1.timeIntervalSince1970)
            timeUntilNextClass = perTwo.timeIntervalSinceNow
        } else if now >= perTwo &&
                    now <= pp2 {
            cpText = "Period Two"
            timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp2.timeIntervalSince1970-perTwo.timeIntervalSince1970)
            timeUntilNextClass = pp2.timeIntervalSinceNow
        } else if now >= pp2 &&
                    now <= perThree {
            cpText = "Passing Period"
            timeText = (String(Int(perThree.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perThree.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perThree.timeIntervalSince1970-pp2.timeIntervalSince1970)
            timeUntilNextClass = perThree.timeIntervalSinceNow
        } else if now >= perThree &&
                    now <= firstLunchStart {
            cpText = "Period Three"
            timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perThree.timeIntervalSince1970)
            timeUntilNextClass = firstLunchStart.timeIntervalSinceNow
        } else if now >= firstLunchStart &&
                    now <= firstLunchEnd {
            cpText = "Lunch"
            timeText = (String(Int(firstLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchEnd.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
            timeUntilNextClass = firstLunchEnd.timeIntervalSinceNow
        } else if now >= firstLunchEnd &&
                    now <= perFour {
            cpText = "Passing Period"
            timeText = (String(Int(perFour.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFour.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFour.timeIntervalSince1970-firstLunchEnd.timeIntervalSince1970)
            timeUntilNextClass = perFour.timeIntervalSinceNow
        } else if now >= perFour &&
                    now <= pp4 {
            cpText = "Period Four"
            timeText = (String(Int(pp4.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp4.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp4.timeIntervalSince1970-perFour.timeIntervalSince1970)
            timeUntilNextClass = pp4.timeIntervalSinceNow
        } else if now >= pp4 &&
                    now <= perFive {
            cpText = "Passing Period"
            timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFive.timeIntervalSince1970-pp4.timeIntervalSince1970)
            timeUntilNextClass = perFive.timeIntervalSinceNow
        } else if now >= perFive &&
                    now <= pp5 {
            cpText = "Period Five"
            timeText = (String(Int(pp5.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp5.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp5.timeIntervalSince1970-perFive.timeIntervalSince1970)
            timeUntilNextClass = pp5.timeIntervalSinceNow
        } else if now >= pp5 &&
                    now <= perSix {
            cpText = "Passing Period"
            timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp5.timeIntervalSince1970)
            timeUntilNextClass = perSix.timeIntervalSinceNow
        } else if now >= perSix &&
                    now <= schoolEnd {
            cpText = "Period Six"
            timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
            
            timeUntilNextClass = schoolEnd.timeIntervalSinceNow
        } else {
            cpText = "You are not in school hours"
            progress = 0
            timeText = "00:00"
        }
        
        if cpText != "You are not in school hours" {
            if !((timeUntilNextClass) <= 1) {
        progress = (1-(timeUntilNextClass / timeWhenClassEnds))
            } else {
                
                if !animationShowing {
                    animationShowing = true
                    timeRemaining = 100
                    
                }
            }
        }
            } else {  if now >= perOne &&
                            now <= pp1
                       {
                              cpText = "Period One"
                              timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                            timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
                            timeUntilNextClass = pp1.timeIntervalSinceNow
                              
                          } else if now >= pp1 &&
                                      now <= perTwo {
                              cpText = "Passing Period"
                              timeText = (String(Int(perTwo.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(perTwo.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(perTwo.timeIntervalSince1970-pp1.timeIntervalSince1970)
                              timeUntilNextClass = perTwo.timeIntervalSinceNow
                          } else if now >= perTwo &&
                                      now <= pp2 {
                              cpText = "Period Two"
                              timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(pp2.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                              timeUntilNextClass = pp2.timeIntervalSinceNow
                          } else if now >= pp2 &&
                                      now <= perThree {
                              cpText = "Passing Period"
                              timeText = (String(Int(perThree.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(perThree.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(perThree.timeIntervalSince1970-pp2.timeIntervalSince1970)
                              timeUntilNextClass = perThree.timeIntervalSinceNow
                          } else if now >= perThree &&
                                      now <= firstLunchStart {
                              cpText = "Period Three"
                              timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perThree.timeIntervalSince1970)
                              timeUntilNextClass = firstLunchStart.timeIntervalSinceNow
                          } else if now >= firstLunchStart &&
                                      now <= perFour1 {
                              cpText = "Passing Period"
                              timeText = (String(Int(perFour1.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(perFour1.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(perFour1.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
                              timeUntilNextClass = perFour1.timeIntervalSinceNow
                          } else if now >= perFour1 &&
                                      now <= secondLunchStart {
                              cpText = "Period Four"
                              timeText = (String(Int(secondLunchStart.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(secondLunchStart.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(secondLunchStart.timeIntervalSince1970-perFour1.timeIntervalSince1970)
                              timeUntilNextClass = secondLunchStart.timeIntervalSinceNow
                          } else if now >= secondLunchStart &&
                                          now <= secondLunchEnd {
                                  cpText = "Lunch"
                                  timeText = (String(Int(secondLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
                                  timeText += String(format: "%02d", Int(secondLunchEnd.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(secondLunchEnd.timeIntervalSince1970-secondLunchStart.timeIntervalSince1970)
                              timeUntilNextClass = secondLunchEnd.timeIntervalSinceNow
                              
                          } else if now >= pp4 &&
                                      now <= perFive {
                              cpText = "Passing Period"
                              timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(perFive.timeIntervalSince1970-pp4.timeIntervalSince1970)
                              timeUntilNextClass = perFive.timeIntervalSinceNow
                          } else if now >= perFive &&
                                      now <= pp5 {
                              cpText = "Period Five"
                              timeText = (String(Int(pp5.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(pp5.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(pp5.timeIntervalSince1970-perFive.timeIntervalSince1970)
                              timeUntilNextClass = pp5.timeIntervalSinceNow
                          } else if now >= pp5 &&
                                      now <= perSix {
                              cpText = "Passing Period"
                              timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp5.timeIntervalSince1970)
                              timeUntilNextClass = perSix.timeIntervalSinceNow
                          } else if now >= perSix &&
                                      now <= schoolEnd {
                              cpText = "Period Six"
                              timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
                              timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
                              timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
                              
                              timeUntilNextClass = schoolEnd.timeIntervalSinceNow
                          } else {
                              cpText = "You are not in school hours"
                              progress = 0
                              timeText = "00:00"
                          }
                          
                          if cpText != "You are not in school hours" {
                              if !((timeUntilNextClass) <= 1) {
                          progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                              } else {
                                  
                                  if !animationShowing {
                                      animationShowing = true
                                      timeRemaining = 100
                                      
                                  }
                              }
                          }}
    }
 else if now.dayOfWeek() == "Thursday" {
     let perOne = calendar.date(
         bySettingHour: 8,
         minute: 30,
         second: 13,
         of: now)!
     let pp1 = calendar.date(
         bySettingHour: 10,
         minute: 18,
         second: 13,
         of: now)!
     let officeHours = calendar.date(
         bySettingHour: 10,
         minute: 26,
         second: 13,
         of: now)!
     let pp2 = calendar.date(
         bySettingHour: 10,
         minute: 56,
         second: 13,
         of: now)!

     let perThree1 = calendar.date(
         bySettingHour: 11,
         minute: 04,
         second: 13,
         of: now)!
     let firstLunchStart = calendar.date(
         bySettingHour: 11,
         minute: 54,
         second: 13,
         of: now)!
     let firstLunchEnd = calendar.date(
         bySettingHour: 12,
         minute: 34,
         second: 13,
         of: now)!
      let secondLunchStart = calendar.date(
          bySettingHour: 13,
          minute: 00,
          second: 13,
          of: now)!
      let secondLunchEnd = calendar.date(
          bySettingHour: 13,
          minute: 40,
          second: 13,
          of: now)!
      let perThree = calendar.date(
          bySettingHour: 11,
          minute: 04,
          second: 13,
          of: now)!
      
         let perThree2 = calendar.date(
             bySettingHour: 12,
             minute: 42,
             second: 13,
             of: now)!
         let pp3 = calendar.date(
             bySettingHour: 14,
             minute: 40,
             second: 13,
             of: now)!

         let perFive = calendar.date(
             bySettingHour: 13,
             minute: 48,
             second: 13,
             of: now)!
         let schoolEnd = calendar.date(
             bySettingHour: 15,
             minute: 36,
             second: 13,
             of: now)!
         
         if firstLunchOdd {
         if now >= perOne &&
           now <= pp1
      {
             cpText = "Period One"
             timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
             
             timeUntilNextClass = pp1.timeIntervalSinceNow
         } else if now >= pp1 &&
                     now <= officeHours {
             cpText = "Passing Period"
             timeText = (String(Int(officeHours.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(officeHours.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(officeHours.timeIntervalSince1970-pp1.timeIntervalSince1970)
             
             timeUntilNextClass = officeHours.timeIntervalSinceNow
         } else if now >= officeHours &&
                     now <= pp2 {
             cpText = "Office Hours"
             timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(pp2.timeIntervalSince1970-officeHours.timeIntervalSince1970)
             
             timeUntilNextClass = pp2.timeIntervalSinceNow
     } else if now >= pp2 &&
                 now <= perThree1 {
         cpText = "Passing Period"
         timeText = (String(Int(perThree1.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(perThree1.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(perThree1.timeIntervalSince1970-pp2.timeIntervalSince1970)
         
         timeUntilNextClass = perThree1.timeIntervalSinceNow

     } else if now >= perThree1 &&
                 now <= firstLunchStart {
         cpText = "Period Three"
         timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perThree1.timeIntervalSince1970)
         
         timeUntilNextClass = firstLunchStart.timeIntervalSinceNow

     } else if now >= firstLunchStart &&
                 now <= firstLunchEnd {
         cpText = "Lunch"
         timeText = (String(Int(firstLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(firstLunchEnd.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(firstLunchEnd.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
         
         timeUntilNextClass = firstLunchEnd.timeIntervalSinceNow
         
     } else if now >= firstLunchEnd &&
                 now <= perThree2 {
         cpText = "Passing Period"
         timeText = (String(Int(perThree2.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(perThree2.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(perThree2.timeIntervalSince1970-firstLunchEnd.timeIntervalSince1970)
         
         timeUntilNextClass = perThree2.timeIntervalSinceNow
         
     } else if now >= perThree2 &&
                 now <= pp3 {
         cpText = "Period Three"
         timeText = (String(Int(pp3.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(pp3.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(pp3.timeIntervalSince1970-perThree2.timeIntervalSince1970)
         
         timeUntilNextClass = pp3.timeIntervalSinceNow
     } else if now >= pp3 &&
                 now <= perFive {
         cpText = "Passing Period"
         timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(perFive.timeIntervalSince1970-pp3.timeIntervalSince1970)
         
         timeUntilNextClass = perFive.timeIntervalSinceNow
         
     } else if now >= perFive &&
                 now <= schoolEnd {
         cpText = "Fifth Period"
         timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
         timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
         timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perFive.timeIntervalSince1970)
         
         timeUntilNextClass = schoolEnd.timeIntervalSinceNow

     } else {
         cpText = "You are not in school hours"
         progress = 0
         timeText = "00:00"
     }
         
         if cpText != "You are not in school hours" {
             if !((timeUntilNextClass) <= 1) {
         progress = (1-(timeUntilNextClass / timeWhenClassEnds))
             } else {
                 
                 if !animationShowing {
                     animationShowing = true
                     timeRemaining = 100
                     
                 }
             }
         }
         } else {
             if now >= perOne &&
               now <= pp1
          {
                 cpText = "Period One"
                 timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                 timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                 timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perOne.timeIntervalSince1970)
                 
                 timeUntilNextClass = pp1.timeIntervalSinceNow
             } else if now >= pp1 &&
                         now <= officeHours {
                 cpText = "Passing Period"
                 timeText = (String(Int(officeHours.timeIntervalSinceNow+0.5)/60)+":")
                 timeText += String(format: "%02d", Int(officeHours.timeIntervalSinceNow+0.5)%60)
                 timeWhenClassEnds = Double(officeHours.timeIntervalSince1970-pp1.timeIntervalSince1970)
                 
                 timeUntilNextClass = officeHours.timeIntervalSinceNow
             } else if now >= officeHours &&
                         now <= pp2 {
                 cpText = "Office Hours"
                 timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
                 timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
                 timeWhenClassEnds = Double(pp2.timeIntervalSince1970-officeHours.timeIntervalSince1970)
                 
                 timeUntilNextClass = pp2.timeIntervalSinceNow
         } else if now >= pp2 &&
                     now <= perThree {
             cpText = "Passing Period"
             timeText = (String(Int(perThree1.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(perThree1.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(perThree1.timeIntervalSince1970-pp2.timeIntervalSince1970)
             
             timeUntilNextClass = perThree1.timeIntervalSinceNow

         } else if now >= perThree &&
                     now <= secondLunchStart {
             cpText = "Period Three"
             timeText = (String(Int(secondLunchStart.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(secondLunchStart.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(secondLunchStart.timeIntervalSince1970-perThree.timeIntervalSince1970)
             
             timeUntilNextClass = secondLunchStart.timeIntervalSinceNow

         } else if now >= secondLunchStart &&
                     now <= secondLunchEnd {
             cpText = "Lunch"
             timeText = (String(Int(secondLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(secondLunchEnd.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(secondLunchEnd.timeIntervalSince1970-secondLunchStart.timeIntervalSince1970)
             
             timeUntilNextClass = secondLunchEnd.timeIntervalSinceNow
             
         }  else if now >= secondLunchEnd &&
                     now <= perFive {
             cpText = "Passing Period"
             timeText = (String(Int(perFive.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(perFive.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(perFive.timeIntervalSince1970-secondLunchEnd.timeIntervalSince1970)
             
             timeUntilNextClass = perFive.timeIntervalSinceNow
             
         } else if now >= perFive &&
                     now <= schoolEnd {
             cpText = "Fifth Period"
             timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
             timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
             timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perFive.timeIntervalSince1970)
             
             timeUntilNextClass = schoolEnd.timeIntervalSinceNow

         } else {
             cpText = "You are not in school hours"
             progress = 0
             timeText = "00:00"
         }
             
             if cpText != "You are not in school hours" {
                 if !((timeUntilNextClass) <= 1) {
             progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                 } else {
                     
                     if !animationShowing {
                         animationShowing = true
                         timeRemaining = 100
                         
                     }
                 }
             }
         }
            } else if now.dayOfWeek() == "Friday" {
                let perTwo = calendar.date(
                    bySettingHour: 8,
                    minute: 30,
                    second: 13,
                    of: now)!
                let pp1 = calendar.date(
                    bySettingHour: 10,
                    minute: 18,
                    second: 13,
                    of: now)!
                let officeHours = calendar.date(
                    bySettingHour: 10,
                    minute: 26,
                    second: 13,
                    of: now)!
                let pp2 = calendar.date(
                    bySettingHour: 10,
                    minute: 56,
                    second: 13,
                    of: now)!

                let perFour1 = calendar.date(
                    bySettingHour: 11,
                    minute: 04,
                    second: 13,
                    of: now)!
                let firstLunchStart = calendar.date(
                    bySettingHour: 11,
                    minute: 54,
                    second: 13,
                    of: now)!
                let firstLunchEnd = calendar.date(
                    bySettingHour: 12,
                    minute: 34,
                    second: 13,
                    of: now)!
                 let secondLunchStart = calendar.date(
                     bySettingHour: 13,
                     minute: 00,
                     second: 13,
                     of: now)!
                 let secondLunchEnd = calendar.date(
                     bySettingHour: 13,
                     minute: 40,
                     second: 13,
                     of: now)!
                 let perFour = calendar.date(
                     bySettingHour: 11,
                     minute: 04,
                     second: 13,
                     of: now)!
                 
                    let perFour2 = calendar.date(
                        bySettingHour: 12,
                        minute: 42,
                        second: 13,
                        of: now)!
                    let pp3 = calendar.date(
                        bySettingHour: 14,
                        minute: 40,
                        second: 13,
                        of: now)!

                    let perSix = calendar.date(
                        bySettingHour: 13,
                        minute: 48,
                        second: 13,
                        of: now)!
                    let schoolEnd = calendar.date(
                        bySettingHour: 15,
                        minute: 36,
                        second: 13,
                        of: now)!
            
            if firstLunchEven {
            if now >= perTwo &&
                now <= pp1
            {
                cpText = "Period Two"
                timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                
                timeUntilNextClass = pp1.timeIntervalSinceNow
            } else if now >= pp1 &&
                        now <= officeHours {
                cpText = "Passing Period"
                timeText = (String(Int(officeHours.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(officeHours.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(officeHours.timeIntervalSince1970-pp1.timeIntervalSince1970)
                
                timeUntilNextClass = officeHours.timeIntervalSinceNow
            } else if now >= officeHours &&
                        now <= pp2 {
                cpText = "Office Hours"
                timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(pp2.timeIntervalSince1970-officeHours.timeIntervalSince1970)
                
                timeUntilNextClass = pp2.timeIntervalSinceNow
        } else if now >= pp2 &&
                    now <= perFour1 {
            cpText = "Passing Period"
            timeText = (String(Int(perFour1.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFour1.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFour1.timeIntervalSince1970-pp2.timeIntervalSince1970)
            
            timeUntilNextClass = perFour1.timeIntervalSinceNow

        } else if now >= perFour1 &&
                    now <= firstLunchStart {
            cpText = "Period Four"
            timeText = (String(Int(firstLunchStart.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchStart.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchStart.timeIntervalSince1970-perFour1.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchStart.timeIntervalSinceNow

        } else if now >= firstLunchStart &&
                    now <= firstLunchEnd {
            cpText = "Lunch"
            timeText = (String(Int(firstLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(firstLunchEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(firstLunchEnd.timeIntervalSince1970-firstLunchStart.timeIntervalSince1970)
            
            timeUntilNextClass = firstLunchEnd.timeIntervalSinceNow
            
        } else if now >= firstLunchEnd &&
                    now <= perFour2 {
            cpText = "Passing Period"
            timeText = (String(Int(perFour2.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perFour2.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perFour2.timeIntervalSince1970-firstLunchEnd.timeIntervalSince1970)
            
            timeUntilNextClass = perFour2.timeIntervalSinceNow
            
        } else if now >= perFour2 &&
                    now <= pp3 {
            cpText = "Period Four"
            timeText = (String(Int(pp3.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(pp3.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(pp3.timeIntervalSince1970-perFour2.timeIntervalSince1970)
            
            timeUntilNextClass = pp3.timeIntervalSinceNow
        } else if now >= pp3 &&
                    now <= perSix {
            cpText = "Passing Period"
            timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp3.timeIntervalSince1970)
            
            timeUntilNextClass = perSix.timeIntervalSinceNow
            
        } else if now >= perSix &&
                    now <= schoolEnd {
            cpText = "Sixth Period"
            timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
            timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
            timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
            
            timeUntilNextClass = schoolEnd.timeIntervalSinceNow

        } else {
            cpText = "You are not in school hours"
            progress = 0
            timeText = "00:00"
        }
            
            if cpText != "You are not in school hours" {
                if !((timeUntilNextClass) <= 1) {
            progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                } else {
                    
                    if !animationShowing {
                        animationShowing = true
                        timeRemaining = 100
                        
                    }
                }
            }
            } else {
                if now >= perTwo &&
                    now <= pp1
                {
                    cpText = "Period Two"
                    timeText = (String(Int(pp1.timeIntervalSinceNow+0.5)/60)+":")
                    timeText += String(format: "%02d", Int(pp1.timeIntervalSinceNow+0.5)%60)
                    timeWhenClassEnds = Double(pp1.timeIntervalSince1970-perTwo.timeIntervalSince1970)
                    
                    timeUntilNextClass = pp1.timeIntervalSinceNow
                } else if now >= pp1 &&
                            now <= officeHours {
                    cpText = "Passing Period"
                    timeText = (String(Int(officeHours.timeIntervalSinceNow+0.5)/60)+":")
                    timeText += String(format: "%02d", Int(officeHours.timeIntervalSinceNow+0.5)%60)
                    timeWhenClassEnds = Double(officeHours.timeIntervalSince1970-pp1.timeIntervalSince1970)
                    
                    timeUntilNextClass = officeHours.timeIntervalSinceNow
                } else if now >= officeHours &&
                            now <= pp2 {
                    cpText = "Office Hours"
                    timeText = (String(Int(pp2.timeIntervalSinceNow+0.5)/60)+":")
                    timeText += String(format: "%02d", Int(pp2.timeIntervalSinceNow+0.5)%60)
                    timeWhenClassEnds = Double(pp2.timeIntervalSince1970-officeHours.timeIntervalSince1970)
                    
                    timeUntilNextClass = pp2.timeIntervalSinceNow
            } else if now >= pp2 &&
                        now <= perFour {
                cpText = "Passing Period"
                timeText = (String(Int(perFour1.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perFour1.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perFour1.timeIntervalSince1970-pp2.timeIntervalSince1970)
                
                timeUntilNextClass = perFour1.timeIntervalSinceNow

            } else if now >= perFour &&
                        now <= secondLunchStart {
                cpText = "Period Four"
                timeText = (String(Int(secondLunchStart.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(secondLunchStart.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(secondLunchStart.timeIntervalSince1970-perFour.timeIntervalSince1970)
                
                timeUntilNextClass = secondLunchStart.timeIntervalSinceNow

            } else if now >= secondLunchStart &&
                        now <= secondLunchEnd {
                cpText = "Lunch"
                timeText = (String(Int(secondLunchEnd.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(secondLunchEnd.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(secondLunchEnd.timeIntervalSince1970-secondLunchStart.timeIntervalSince1970)
                
                timeUntilNextClass = secondLunchEnd.timeIntervalSinceNow
                
            }  else if now >= secondLunchEnd &&
                        now <= perSix {
                cpText = "Passing Period"
                timeText = (String(Int(perSix.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(perSix.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(perSix.timeIntervalSince1970-pp3.timeIntervalSince1970)
                
                timeUntilNextClass = perSix.timeIntervalSinceNow
                
            } else if now >= perSix &&
                        now <= schoolEnd {
                cpText = "Sixth Period"
                timeText = (String(Int(schoolEnd.timeIntervalSinceNow+0.5)/60)+":")
                timeText += String(format: "%02d", Int(schoolEnd.timeIntervalSinceNow+0.5)%60)
                timeWhenClassEnds = Double(schoolEnd.timeIntervalSince1970-perSix.timeIntervalSince1970)
                
                timeUntilNextClass = schoolEnd.timeIntervalSinceNow

            } else {
                cpText = "You are not in school hours"
                progress = 0
                timeText = "00:00"
            }
                
                if cpText != "You are not in school hours" {
                    if !((timeUntilNextClass) <= 1) {
                progress = (1-(timeUntilNextClass / timeWhenClassEnds))
                    } else {
                        
                        if !animationShowing {
                            animationShowing = true
                            timeRemaining = 100
                            
                        }
                    }
                }
            }
                }

    }
    init() {
        load()
    }
    var body: some View {
        TabView() {
        VStack() {
            
            Spacer()
        ZStack() {
            Circle()
                        .stroke(Color(hex: 0x212121), lineWidth: 12.0)
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: 180))
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.blue)
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: 180))
        
            Text(timeText).font(.custom("HelveticaNeue", size: 40.0)).fontWeight(.semibold)
        }.padding(.top).onReceive(timer) { time in
            checkTime()

        }
        }.padding(.top)
            VStack() {
                VStack() {
                  
                    Text("Odd Lunch").fontWeight(.semibold).padding(.top).font(.title3).multilineTextAlignment(.center)

                    HStack(spacing: 0) {
                        if !firstLunchOdd {
                        Button(action: {
                            firstLunchOdd = true
                            save()
                            
                        }) {
                            ZStack() {
                                
                                    Text("First").foregroundColor(.white).font(.headline)
                              
                                
                            }
                        }.buttonBorderShape(.capsule).background(Color(hex: 0x121212)).cornerRadius(20)
                        } else {
                            Button(action: {
                                firstLunchOdd = true
                                save()
                                
                            }) {
                                ZStack() {
                                    
                                        Text("First").foregroundColor(.white).font(.headline)
                                  
                                    
                                }
                            }.buttonBorderShape(.capsule).background(Color.gray).cornerRadius(20)
                        }
                        if firstLunchOdd {
                        Button(action: {
                            firstLunchOdd = false
                            save()
                            
                        }) {
                            ZStack() {
                                
                                    Text("Second").foregroundColor(.white).font(.headline)
                              
                                
                            }
                        }.buttonBorderShape(.capsule).background(Color(hex: 0x121212)).cornerRadius(20)
                        } else {
                            Button(action: {
                                firstLunchOdd = false
                                save()
                                
                            }) {
                                ZStack() {
                                    
                                        Text("Second").foregroundColor(.white).font(.headline)
                                  
                                    
                                }
                            }.buttonBorderShape(.capsule).background(Color.gray).cornerRadius(20)
                        }
                        
                    }
                    
                        .padding(.horizontal)
                }
                VStack() {

                    Text("Even lunch").fontWeight(.semibold).padding(.top).font(.title3).multilineTextAlignment(.center)
                       

                    HStack(spacing: 0) {
                        if !firstLunchEven {
                        Button(action: {
                            firstLunchEven = true
                            save()

                        }, label: {
                            ZStack() {

                                   
                                    Text("First").foregroundColor(.white).font(.headline)

                            }
                        }).buttonBorderShape(.capsule).background(Color(hex: 0x121212)).cornerRadius(20)
                        } else {
                            Button(action: {
                                firstLunchEven = true
                                save()

                            }, label: {
                                ZStack() {
   
                                        Text("First").foregroundColor(.white).font(.headline)
                             
                                }
                            }).buttonBorderShape(.capsule).background(Color.gray).cornerRadius(20)
                        }
                        if firstLunchEven {
                        Button(action: {
                            firstLunchEven = false
                            save()

                        }, label: {
                            ZStack() {

                                   
                                    Text("Second").foregroundColor(.white).font(.headline)

                            }
                        }).buttonBorderShape(.capsule).background(Color(hex: 0x121212)).cornerRadius(20)
                        } else {
                            Button(action: {
                                firstLunchEven = false
                                save()

                            }, label: {
                                ZStack() {
   
                                    Text("Second").foregroundColor(.white).font(.headline)
                            
                                }
                            }).buttonBorderShape(.capsule).background(Color.gray).cornerRadius(20)
                        }
                    }


                        .padding(.horizontal)
                }
            }
        }.tabViewStyle(.page).onAppear(perform: load)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
      
    }
}
