//
//  Settings.swift
//  ClassTime
//
//  Created by August Wetterau on 10/17/21.
//

import SwiftUI

struct Settings: View {
     let defaults = UserDefaults.standard
  
    @State var name = ContentView().name
    @State private var firstLunchOdd: Bool  = true
    @State private var firstLunchEven: Bool = true
    
    @State var OddLunchValue = "First Lunch"
    @State var EvenLunchValue = "First Lunch"
    @State var oddList = ["First Lunch", "Second Lunch"]
    @State var evenList = ["First Lunch", "Second Lunch"]
    @State var ERHS = true


    
    func save() {
        
       
        defaults.set(name, forKey: "Name")
        defaults.set(firstLunchOdd, forKey: "Lunch Odd")
        defaults.set(firstLunchEven,forKey: "Lunch Even")
        defaults.set(ERHS, forKey: "School")
        defaults.set(name, forKey: "Name2")

        
        

  
        
    }
    func load(){
        
        let savedName = defaults.string(forKey: "Name")
        let savedLunchOdd = defaults.bool(forKey: "Lunch Odd")
        let savedLunchEven = defaults.bool(forKey: "Lunch Even")
        let setSchool = defaults.bool(forKey: "School")
        
       
    
        firstLunchOdd = savedLunchOdd
        firstLunchEven = savedLunchEven
        name = (savedName ?? " ")
        ERHS = setSchool
        
  
        
        
        if defaults.bool(forKey: "Lunch Odd") {
            OddLunchValue = "First Lunch"
        } else {
            OddLunchValue = "Second Lunch"
        }
        if defaults.bool(forKey: "Lunch Even") {
            EvenLunchValue = "First Lunch"
        } else {
            EvenLunchValue = "Second Lunch"
        }
    }
    
    
    var body: some View {
        ZStack() {
            Color(hex: 0x121212).ignoresSafeArea()
        VStack() {
            HStack() {
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading).padding(.top)
                Spacer()
            }
           
        List() {
            
            
            Section() {
                HStack() {
                    Text("Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Spacer()

                    TextField(name, text: $name).onChange(of: name) { newValue in
                        save()
                    }
                    .multilineTextAlignment(.trailing).onAppear(perform: load).font(.title3).foregroundColor(Color.white.opacity(0.4))
                   
                }
//                HStack() {
//                    Text("Lunches")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    Spacer()
//                    
//                }
                
                
        }
            Section() {
                HStack() {
                    Text("Odd Day").font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                Menu {
                            ForEach(oddList, id: \.self){ client in
                                Button(client) {
                                    self.OddLunchValue = client
                                    if (client == "First Lunch") {
                                        firstLunchOdd = true
                                    } else {
                                        firstLunchOdd = false
                                    }
                                    save()
                                }
                            }
                        } label: {
                            VStack(){
                                HStack{
                                    
                                        Text(OddLunchValue)
                                        .foregroundColor(.gray).font(.title3).padding(.trailing)
                                    
                                   
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .font(Font.system(size: 15, weight: .bold))
                                }
                                .padding(.horizontal)
                                
                            }
                        }.animation(nil)
            }
                HStack() {
                    Text("Even Day").font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                Menu {
                            ForEach(evenList, id: \.self){ client in
                                Button(client) {
                                    self.EvenLunchValue = client
                                    if (client == "First Lunch") {
                                        firstLunchEven = true
                                    } else {
                                        firstLunchEven = false
                                    }
                                    save()
                                }
                            }
                        } label: {
                            VStack(){
                                HStack{
                                    
                                        Text(EvenLunchValue)
                                        .foregroundColor(.gray).font(.title3).padding(.trailing)
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .font(Font.system(size: 15, weight: .bold))
                                }
                                .padding(.horizontal)
                                
                            }
                        }.animation(nil)
            }
            }.listStyle(GroupedListStyle()).onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor(Color(hex: 0x121212))
            
        })
            Section() {
                HStack() {
                    Spacer()
                Button(action: {
                    if !ERHS {
                    ERHS.toggle()
                    save()
                    }
                }) {
                    VStack() {
                    if ERHS {
                        Text("  ERHS  ").font(.title)
                            .fontWeight(.semibold).padding()
                        Image(systemName: "building.2").foregroundColor(.blue).padding().font(.system(size: 50))
                    } else {
                        Text("  ERHS  ").font(.title)
                            .fontWeight(.semibold).foregroundColor(.white).padding()
                        Image(systemName: "building.2").foregroundColor(.white).padding().font(.system(size: 50))
                    }
                    }
                }.buttonStyle(BorderlessButtonStyle())
                   
                    Rectangle().frame(width: 2, height: 120, alignment: .center).foregroundColor(.gray).padding(.leading)
                    Button(action: {
                        if ERHS {
                        ERHS.toggle()
                        save()
                        }
                    }) {
                        VStack() {
                        if ERHS {
                            Text("Santiago").foregroundColor(.white).font(.title)
                                .fontWeight(.semibold).padding()
                            Image(systemName: "building.2").foregroundColor(.white).padding().font(.system(size: 50))
                        } else {
                            Text("Santiago").font(.title)
                                .fontWeight(.semibold).foregroundColor(.blue).padding()
                            Image(systemName: "building.2").padding().font(.system(size: 50))
                        }
                        }
                    }.buttonStyle(BorderlessButtonStyle())
                    Spacer()
                }
            }
    }.listStyle(InsetGroupedListStyle()).onAppear(perform: {
        UITableView.appearance().backgroundColor = UIColor(Color(hex: 0x121212))
        
       
        
    })
        }
            VStack() {
                Spacer()
                Rectangle().frame(width: UIScreen.main.bounds.size.width, height: 4, alignment: .center).foregroundColor(Color(hex: 0x212121)).padding(.top)
            }
        }.onAppear(perform: load)
    } }

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
