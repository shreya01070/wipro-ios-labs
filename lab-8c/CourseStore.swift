
import SwiftUI

class CourseStore: ObservableObject {

    @Published private(set) var courses: [Course] = Course.sampleCourses

    // Change the favourite status of a course
    func toggleFavorite(for courseID: Int) {

        guard let index = courses.firstIndex(where: {
            $0.id == courseID
        }) else {
            return
        }

        courses[index].isFavorite.toggle()
    }

    // Set a particular favourite value
    func setFavorite(_ isFavorite: Bool, for courseID: Int) {

        guard let index = courses.firstIndex(where: {
            $0.id == courseID
        }) else {
            return
        }

        courses[index].isFavorite = isFavorite
    }

    // Get the current favourite status
    func isFavorite(_ courseID: Int) -> Bool {

        courses.first(where: {
            $0.id == courseID
        })?.isFavorite ?? false
    }
}
