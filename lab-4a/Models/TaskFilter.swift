import Foundation

enum TaskFilter: String, CaseIterable, Identifiable {
    case all
    case active
    case completed

    var id: String { rawValue }
}
