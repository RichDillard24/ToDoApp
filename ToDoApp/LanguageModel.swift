import SwiftUI
import Foundation


enum language: String, CaseIterable, Identifiable {
    case english = "en"
    case spanish = "es"
    case french = "fr"

    var id: String { self.rawValue }
    var name: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Español"
        case .french: return "Français"
        }
    }
}
