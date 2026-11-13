import UIKit

class ViewController: UIViewController {

    let headingLabel = UILabel()
    let nameTextField = UITextField()
    let greetButton = UIButton(type: .system)
    let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupScreen()
    }

    func setupScreen() {

        // App heading
        headingLabel.text = "UIKit Demo"
        headingLabel.font = .boldSystemFont(ofSize: 28)
        headingLabel.textAlignment = .center

        // Name input field
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect

        // Button settings
        greetButton.setTitle("Click Me", for: .normal)
        greetButton.backgroundColor = .systemBlue
        greetButton.setTitleColor(.white, for: .normal)
        greetButton.layer.cornerRadius = 8
        greetButton.addTarget(
            self,
            action: #selector(showGreeting),
            for: .touchUpInside
        )

        // Message shown below the button
        messageLabel.text = "Hello, Stranger!"
        messageLabel.font = .systemFont(ofSize: 20)
        messageLabel.textAlignment = .center

        // Arrange everything vertically
        let stack = UIStackView(arrangedSubviews: [
            headingLabel,
            nameTextField,
            greetButton,
            messageLabel
        ])

        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        // Set the position of the stack
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            greetButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func showGreeting() {

        let enteredName = nameTextField.text?
            .trimmingCharacters(in: .whitespaces) ?? ""

        if enteredName.isEmpty {
            messageLabel.text = "Hello, Stranger!"
        } else {
            messageLabel.text = "Hello, \(enteredName)!"
        }
    }
}
