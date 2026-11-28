
import Foundation

struct Course: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var instructor: String
    var durationWeeks: Int

    init(
        id: UUID = UUID(),
        name: String,
        instructor: String,
        durationWeeks: Int
    ) {
        self.id = id
        self.name = name
        self.instructor = instructor
        self.durationWeeks = durationWeeks
    }
}
