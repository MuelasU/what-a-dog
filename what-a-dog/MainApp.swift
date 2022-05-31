//
//  what_a_dogApp.swift
//  what-a-dog
//
//  Created by Gabriel Muelas on 10/05/22.
//

import SwiftUI

@main
struct MainApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
