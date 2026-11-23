
import UIKit

class FormViewController: UIViewController {

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let messageField = UITextField()

    private let errorLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Contact Form"

        setupForm()
    }

    // MARK: - Form UI

    private func setupForm() {

        let heading = UILabel()
        heading.text = "Enter Your Details"
        heading.font = .boldSystemFont(ofSize: 25)

        configureField(nameField, placeholder: "Enter your name")

        configureField(emailField, placeholder: "Enter your email")
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.textContentType = .emailAddress

        configureField(messageField, placeholder: "Enter your message")

        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0

        submitButton.setTitle("Submit Form", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)

        submitButton.heightAnchor.constraint(
            equalToConstant: 48
        ).isActive = true

        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        let stackView = UIStackView(arrangedSubviews: [
            heading,
            nameField,
            emailField,
            messageField,
            errorLabel,
            submitButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 25
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -25
            )
        ])
    }

    private func configureField(
        _ field: UITextField,
        placeholder: String
    ) {

        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing

        field.heightAnchor.constraint(
            equalToConstant: 48
        ).isActive = true
    }

    // MARK: - Form Validation

    @objc private func submitForm() {

        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let email = emailField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let message = messageField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !name.isEmpty else {
            errorLabel.text = "Please enter your name."
            return
        }

        guard !email.isEmpty else {
            errorLabel.text = "Please enter your email."
            return
        }

        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        guard email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil else {

            errorLabel.text = "Please enter a valid email address."
            return
        }

        guard !message.isEmpty else {
            errorLabel.text = "Please enter your message."
            return
        }

        errorLabel.text = nil

        let postsVC = PostsViewController()

        navigationController?.pushViewController(
            postsVC,
            animated: true
        )
    }
}
