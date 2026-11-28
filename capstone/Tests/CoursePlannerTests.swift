
import XCTest
@testable import CoursePlanner

@MainActor
final class CoursePlannerTests: XCTestCase {

    private func makeViewModel() -> CoursePlannerViewModel {
        let testDefaults = UserDefaults(
            suiteName: UUID().uuidString
        )!

        let storage = PlannerStorage(defaults: testDefaults)

        return CoursePlannerViewModel(
            storage: storage,
            loadSampleData: false
        )
    }

    // Test 1: Adding a valid course
    func testAddCourse() {
        let viewModel = makeViewModel()

        let error = viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        XCTAssertNil(error)
        XCTAssertEqual(viewModel.courses.count, 1)
        XCTAssertEqual(viewModel.courses.first?.name, "Swift")
    }

    // Test 2: Rejecting an empty course name
    func testEmptyCourseName() {
        let viewModel = makeViewModel()

        let error = viewModel.addCourse(
            name: " ",
            instructor: "John",
            durationWeeks: 8
        )

        XCTAssertNotNil(error)
        XCTAssertEqual(viewModel.courses.count, 0)
    }

    // Test 3: Preventing duplicate courses
    func testDuplicateCourse() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        let error = viewModel.addCourse(
            name: "swift",
            instructor: "David",
            durationWeeks: 10
        )

        XCTAssertNotNil(error)
        XCTAssertEqual(viewModel.courses.count, 1)
    }

    // Test 4: Deleting a course and its assignments
    func testDeleteCourse() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        let courseID = viewModel.courses[0].id

        viewModel.addAssignment(
            title: "Swift Basics",
            courseID: courseID,
            dueDate: Date()
        )

        viewModel.deleteCourse(id: courseID)

        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertTrue(viewModel.assignments.isEmpty)
    }

    // Test 5: Adding an assignment
    func testAddAssignment() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "iOS Development",
            instructor: "David",
            durationWeeks: 10
        )

        let courseID = viewModel.courses[0].id

        let error = viewModel.addAssignment(
            title: "First Project",
            courseID: courseID,
            dueDate: Date()
        )

        XCTAssertNil(error)
        XCTAssertEqual(viewModel.assignments.count, 1)
    }

    // Test 6: Rejecting an empty assignment title
    func testEmptyAssignmentTitle() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        let courseID = viewModel.courses[0].id

        let error = viewModel.addAssignment(
            title: "",
            courseID: courseID,
            dueDate: Date()
        )

        XCTAssertNotNil(error)
        XCTAssertTrue(viewModel.assignments.isEmpty)
    }

    // Test 7: Marking an assignment completed
    func testToggleAssignment() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        let courseID = viewModel.courses[0].id

        viewModel.addAssignment(
            title: "Arrays",
            courseID: courseID,
            dueDate: Date()
        )

        let assignmentID = viewModel.assignments[0].id

        viewModel.toggleAssignment(id: assignmentID)

        XCTAssertTrue(viewModel.assignments[0].isCompleted)
    }

    // Test 8: Checking pending assignments and progress
    func testPendingAssignmentsAndProgress() {
        let viewModel = makeViewModel()

        viewModel.addCourse(
            name: "Swift",
            instructor: "John",
            durationWeeks: 8
        )

        let courseID = viewModel.courses[0].id

        viewModel.addAssignment(
            title: "Task One",
            courseID: courseID,
            dueDate: Date()
        )

        viewModel.addAssignment(
            title: "Task Two",
            courseID: courseID,
            dueDate: Date()
        )

        let completedID = viewModel.assignments[0].id

        viewModel.toggleAssignment(id: completedID)

        XCTAssertEqual(viewModel.pendingAssignments.count, 1)
        XCTAssertEqual(viewModel.completedAssignments.count, 1)
        XCTAssertEqual(viewModel.completionPercentage, 50)
    }
}
