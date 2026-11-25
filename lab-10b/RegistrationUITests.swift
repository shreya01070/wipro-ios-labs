
import XCTest

final class RegistrationUITests: XCTestCase {

    //  Test Setup

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    //  Successful Registration

    func testSuccessfulRegistration() {

        let app = XCUIApplication()
        app.launch()

        let nameField = app.textFields["registration.name"]
        let emailField = app.textFields["registration.email"]

        // Check that the registration screen has loaded.
        XCTAssertTrue(
            nameField.waitForExistence(timeout: 5),
            "Name field should appear when the app launches."
        )

        // Enter registration details.
        nameField.tap()
        nameField.typeText("Aman Verma")

        emailField.tap()
        emailField.typeText("aman@gmail.com")

        // Hide the keyboard if it is still visible.
        let doneButton = app.toolbars.buttons["Done"]

        if doneButton.exists {
            doneButton.tap()
        }

        // Submit the form.
        let submitButton = app.buttons["registration.submit"]

        XCTAssertTrue(submitButton.waitForExistence(timeout: 5))
        submitButton.tap()

        // Verify the successful registration message.
        let successMessage = app.staticTexts["registration.success"]

        XCTAssertTrue(
            successMessage.waitForExistence(timeout: 5),
            "A success message should appear after valid registration."
        )

        XCTAssertTrue(
            successMessage.label.contains("Aman Verma")
        )
    }


    // Empty Form Validation

    func testEmptyNameShowsValidationError() {

        let app = XCUIApplication()
        app.launch()

        let submitButton = app.buttons["registration.submit"]

        XCTAssertTrue(
            submitButton.waitForExistence(timeout: 5)
        )

        // Submit without entering any details.
        submitButton.tap()

        // Check that the validation message is displayed.
        let errorMessage = app.staticTexts["registration.error"]

        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 5),
            "An error should appear when the name is empty."
        )

        XCTAssertEqual(
            errorMessage.label,
            "Please enter your name."
        )
    }


    //Invalid Email Validation

    func testInvalidEmailShowsValidationError() {

        let app = XCUIApplication()
        app.launch()

        let nameField = app.textFields["registration.name"]
        let emailField = app.textFields["registration.email"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))

        nameField.tap()
        nameField.typeText("Aman Verma")

        emailField.tap()
        emailField.typeText("amanmail.com")

        let doneButton = app.toolbars.buttons["Done"]

        if doneButton.exists {
            doneButton.tap()
        }

        let submitButton = app.buttons["registration.submit"]
        submitButton.tap()

        let errorMessage = app.staticTexts["registration.error"]

        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 5)
        )

        XCTAssertEqual(
            errorMessage.label,
            "Please enter a valid email address."
        )
    }
}
