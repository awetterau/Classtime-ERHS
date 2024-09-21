//
//  ClassTimeApp.swift
//  ClassTime
//
//  Created by August Wetterau on 10/8/21.
//

import SwiftUI

@main
struct ClassTimeApp: App {


    var body: some Scene {
  
        WindowGroup {
            ContentView().environmentObject(GameClass())
        }
       
    }
    
}
