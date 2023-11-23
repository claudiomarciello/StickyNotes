//
//  StickyNotesNC1App.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 22/11/23.
//

import SwiftUI
import SwiftData

@main
struct StickyNotesNC1App: App {
    
    let container: ModelContainer = {
        let schema = Schema([Note.self])
        let container = try! ModelContainer(for: schema)
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(container)
        
    }
}
