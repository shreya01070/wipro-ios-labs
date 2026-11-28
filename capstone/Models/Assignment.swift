
import Foundation

struct Assignment: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var courseID: UUID
    var dueDate: Date
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        title: String,
        courseID: UUID,
        dueDate: Date,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.courseID = courseID
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
