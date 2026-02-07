//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Richard Dillard on 1/24/26.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    @AppStorage("selectedLanguage") private var selectedLanguage: language = .english
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: selectedLanguage.rawValue))
        }
    }
}
