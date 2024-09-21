//
//  ClassTimeApp.swift
//  ClassTime ERHS WatchKit Extension
//
//  Created by August Wetterau on 10/22/21.
//

import SwiftUI

@main
struct ClassTimeApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
