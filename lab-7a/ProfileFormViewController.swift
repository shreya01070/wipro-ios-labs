
import UIKit

class ProfileFormViewController: UIViewController, UITextFieldDelegate {

    // UI Elements

    private let scrollView = UIScrollView()
    private let formStack = UIStackView()

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let courseField = UITextField()

    private let nameError = UILabel()
    private let emailError = UILabel()
    private let courseError = UILabel()

    private let submitButton = UIButton(type: .system)

    //View Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile Form"
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupForm()
        setupKeyboardHandling()
    }

    //Scroll View

    private func setupScrollView() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    //Form Layout

    private func setupForm() {

        formStack.axis = .vertical
        formStack.spacing = 18
        formStack.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(formStack)

        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 30),
            formStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -30),
            formStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 24),
            formStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -24)
        ])

        let heading = UILabel()
        heading.text = "Create Your Profile"
        heading.font = .preferredFont(forTextStyle: .largeTitle)
        heading.adjustsFontForContentSizeCategory = true
        heading.font = .boldSystemFont(ofSize: 28)

        let subtitle = UILabel()
        subtitle.text = "Please enter your details below."
        subtitle.font = .preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 0

        configureField(
            nameField,
            placeholder: "Enter your full name",
            contentType: .name,
            keyboard: .default
        )

        configureField(
            emailField,
            placeholder: "Enter your email address",
            contentType: .emailAddress,
            keyboard: .emailAddress
        )

        configureField(
            courseField,
            placeholder: "Enter your course",
            contentType: nil,
            keyboard: .default
        )

        configureErrorLabel(nameError)
        configureErrorLabel(emailError)
        configureErrorLabel(courseError)

        nameField.accessibilityLabel = "Full name"
        emailField.accessibilityLabel = "Email address"
        courseField.accessibilityLabel = "Course"

        submitButton.setTitle("Submit Profile", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        submitButton.accessibilityLabel = "Submit profile"

        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        nameField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        courseField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)

        formStack.addArrangedSubview(heading)
        formStack.addArrangedSubview(subtitle)

        addFieldSection(title: "Full Name", field: nameField, error: nameError)
        addFieldSection(title: "Email Address", field: emailField, error: emailError)
        addFieldSection(title: "Course", field: courseField, error: courseError)

        formStack.addArrangedSubview(submitButton)
    }

    // Field Configuration

    private func configureField(
        _ field: UITextField,
        placeholder: String,
        contentType: UITextContentType?,
        keyboard: UIKeyboardType
    ) {

        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.font = .preferredFont(forTextStyle: .body)
        field.adjustsFontForContentSizeCategory = true

        field.keyboardType = keyboard
        field.textContentType = contentType
        field.autocorrectionType = .no
        field.autocapitalizationType = .none

        field.clearButtonMode = .whileEditing
        field.returnKeyType = .next
        field.delegate = self

        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func configureErrorLabel(_ label: UILabel) {

        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.isHidden = true
    }

    private func addFieldSection(
        title: String,
        field: UITextField,
        error: UILabel
    ) {

        let section = UIStackView()
        section.axis = .vertical
        section.spacing = 7

        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)

        section.addArrangedSubview(label)
        section.addArrangedSubview(field)
        section.addArrangedSubview(error)

        formStack.addArrangedSubview(section)
    }

    //Keyboard Handling

    private func setupKeyboardHandling() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == nameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            courseField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }

    // Validation

    private func validateForm() -> Bool {

        var isValid = true

        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let course = courseField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        // Name validation

        if name.isEmpty {
            nameError.text = "Please enter your name."
            nameError.isHidden = false
            isValid = false
        } else {
            nameError.isHidden = true
        }

        // Email validation

        if email.isEmpty {
            emailError.text = "Please enter your email address."
            emailError.isHidden = false
            isValid = false
        } else if !isValidEmail(email) {
            emailError.text = "Please enter a valid email address."
            emailError.isHidden = false
            isValid = false
        } else {
            emailError.isHidden = true
        }

        // Course validation

        if course.isEmpty {
            courseError.text = "Please enter your course."
            courseError.isHidden = false
            isValid = false
        } else {
            courseError.isHidden = true
        }

        return isValid
    }

    private func isValidEmail(_ email: String) -> Bool {

        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil
    }

    // Submit Button

    @objc private func submitForm() {

        view.endEditing(true)

        if validateForm() {

            let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let course = courseField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            let alert = UIAlertController(
                title: "Profile Submitted",
                message: """
                Name: \(name)
                Email: \(email)
                Course: \(course)

                Your profile has been submitted successfully.
                """,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default))

            present(alert, animated: true)
        }
    }

    // Clear Errors While Typing

    @objc private func fieldChanged() {

        if nameField.text?.isEmpty == false {
            nameError.isHidden = true
        }

        if emailField.text?.isEmpty == false {
            emailError.isHidden = true
        }

        if courseField.text?.isEmpty == false {
            courseError.isHidden = true
        }
    }
}
