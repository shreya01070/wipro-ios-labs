import Foundation

struct Task: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
