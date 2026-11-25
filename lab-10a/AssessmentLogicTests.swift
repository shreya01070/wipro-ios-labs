
import XCTest
@testable import Lab10A

final class AssessmentLogicTests: XCTestCase {

    // Grade Calculation Tests

    func testGradeAForHighMarks() {
        let result = GradeCalculator.calculateGrade(for: 95)

        XCTAssertEqual(result, "A")
    }

    func testGradeChangesAtNinetyMarks() {
        let result = GradeCalculator.calculateGrade(for: 90)

        XCTAssertEqual(result, "A")
    }

    func testGradeBForMarksBelowNinety() {
        let result = GradeCalculator.calculateGrade(for: 85)

        XCTAssertEqual(result, "B")
    }

    func testZeroMarksReturnsFailGrade() {
        let result = GradeCalculator.calculateGrade(for: 0)

        XCTAssertEqual(result, "F")
    }

    func testNegativeMarksAreRejected() {
        let result = GradeCalculator.calculateGrade(for: -5)

        XCTAssertNil(result)
    }

    func testMarksAboveHundredAreRejected() {
        let result = GradeCalculator.calculateGrade(for: 105)

        XCTAssertNil(result)
    }

    func testInvalidNaNMarksAreRejected() {
        let result = GradeCalculator.calculateGrade(for: Double.nan)

        XCTAssertNil(result)
    }


    //  Form Validation Tests

    func testValidRegistrationDetails() {
        let result = RegistrationValidator.validate(
            name: "Aman Verma",
            email: "aman@gmail.com"
        )

        XCTAssertTrue(result)
    }

    func testEmptyNameIsNotAccepted() {
        let result = RegistrationValidator.validate(
            name: "   ",
            email: "aman@gmail.com"
        )

        XCTAssertFalse(result)
    }

    func testInvalidEmailIsNotAccepted() {
        let result = RegistrationValidator.validate(
            name: "Aman Verma",
            email: "amanmail.com"
        )

        XCTAssertFalse(result)
    }

    func testEmailWithoutDomainExtensionIsRejected() {
        let result = RegistrationValidator.validate(
            name: "Aman Verma",
            email: "aman@gmail"
        )

        XCTAssertFalse(result)
    }


    // ViewModel Tests

    func testFavouriteCourseCanBeAddedAndRemoved() {

        let viewModel = CourseViewModel()
        let course = Course(title: "Swift Programming")

        // Initially, the course should not be a favourite.
        XCTAssertFalse(viewModel.isFavourite(course))

        // Add it to favourites.
        viewModel.toggleFavourite(for: course)

        XCTAssertTrue(viewModel.isFavourite(course))

        // Remove it again.
        viewModel.toggleFavourite(for: course)

        XCTAssertFalse(viewModel.isFavourite(course))
    }
}
