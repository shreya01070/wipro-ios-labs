
import Foundation
import Combine

@MainActor
final class CoursePlannerViewModel: ObservableObject {

    @Published private(set) var courses: [Course] = []
    @Published private(set) var assignments: [Assignment] = []

    private let storage: PlannerStorage

    init(
        storage: PlannerStorage = PlannerStorage(),
        loadSampleData: Bool = true
    ) {
        self.storage = storage

        courses = storage.loadCourses()
        assignments = storage.loadAssignments()

        if loadSampleData && !storage.hasStoredData {
            addSampleData()
        }
    }

    // Course Operations

    func addCourse(
        name: String,
        instructor: String,
        durationWeeks: Int
    ) -> String? {

        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let error = ValidationHelper.validateCourseName(cleanedName) {
            return error
        }

        if let error = ValidationHelper.validateDuration(durationWeeks) {
            return error
        }

        let alreadyExists = courses.contains {
            $0.name.lowercased() == cleanedName.lowercased()
        }

        if alreadyExists {
            return "This course already exists."
        }

        let newCourse = Course(
            name: cleanedName,
            instructor: instructor.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            durationWeeks: durationWeeks
        )

        courses.append(newCourse)
        saveCourses()

        return nil
    }

    func deleteCourse(id: UUID) {
        courses.removeAll { $0.id == id }

        // Remove assignments belonging to this course.
        assignments.removeAll { $0.courseID == id }

        saveCourses()
        saveAssignments()
    }

    //  Assignment Operations

    func addAssignment(
        title: String,
        courseID: UUID,
        dueDate: Date
    ) -> String? {

        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let error = ValidationHelper.validateAssignmentTitle(cleanedTitle) {
            return error
        }

        guard courses.contains(where: { $0.id == courseID }) else {
            return "Please select a valid course."
        }

        let newAssignment = Assignment(
            title: cleanedTitle,
            courseID: courseID,
            dueDate: dueDate
        )

        assignments.append(newAssignment)
        saveAssignments()

        return nil
    }

    func toggleAssignment(id: UUID) {
        guard let index = assignments.firstIndex(
            where: { $0.id == id }
        ) else {
            return
        }

        assignments[index].isCompleted.toggle()
        saveAssignments()
    }

    func deleteAssignment(id: UUID) {
        assignments.removeAll { $0.id == id }
        saveAssignments()
    }

    // Collection Transformations

    var pendingAssignments: [Assignment] {
        assignments
            .filter { !$0.isCompleted }
            .sorted { $0.dueDate < $1.dueDate }
    }

    var completedAssignments: [Assignment] {
        assignments.filter { $0.isCompleted }
    }

    var completionPercentage: Int {
        guard !assignments.isEmpty else {
            return 0
        }

        let completedCount = completedAssignments.count

        return Int(
            (Double(completedCount) / Double(assignments.count)) * 100
        )
    }

    func courseName(for courseID: UUID) -> String {
        courses.first(where: { $0.id == courseID })?.name
            ?? "Unknown Course"
    }

    // Storage

    private func saveCourses() {
        storage.saveCourses(courses)
    }

    private func saveAssignments() {
        storage.saveAssignments(assignments)
    }

    //  Sample Data

    private func addSampleData() {

        let swiftCourse = Course(
            name: "Swift Programming",
            instructor: "John Smith",
            durationWeeks: 8
        )

        let iosCourse = Course(
            name: "iOS Development",
            instructor: "David Miller",
            durationWeeks: 10
        )

        courses = [swiftCourse, iosCourse]

        assignments = [
            Assignment(
                title: "Swift Basics",
                courseID: swiftCourse.id,
                dueDate: Calendar.current.date(
                    byAdding: .day,
                    value: 3,
                    to: Date()
                ) ?? Date()
            ),
            Assignment(
                title: "Structures and Classes",
                courseID: swiftCourse.id,
                dueDate: Calendar.current.date(
                    byAdding: .day,
                    value: 5,
                    to: Date()
                ) ?? Date()
            ),
            Assignment(
                title: "SwiftUI Introduction",
                courseID: iosCourse.id,
                dueDate: Calendar.current.date(
                    byAdding: .day,
                    value: 7,
                    to: Date()
                ) ?? Date(),
                isCompleted: true
            )
        ]

        saveCourses()
        saveAssignments()
    }
}
