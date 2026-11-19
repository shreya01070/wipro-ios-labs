import UIKit

class SecondViewController: UIViewController {

    let messageLabel = UILabel()
    let backButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Second: View did load")

        view.backgroundColor = .systemGray6
        title = "Second Screen"

        setupScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Second: View will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Second: View did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Second: View will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("Second: View did disappear")
    }

    func setupScreen() {

        messageLabel.text = "You are on the Second Screen"
        messageLabel.font = .systemFont(ofSize: 20)
        messageLabel.textAlignment = .center

        backButton.setTitle("Back to Home", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 18)

        backButton.addTarget(
            self,
            action: #selector(goBack),
            for: .touchUpInside
        )

        let stack = UIStackView(arrangedSubviews: [
            messageLabel,
            backButton
        ])

        stack.axis = .vertical
        stack.spacing = 25
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func goBack() {

        navigationController?.popViewController(animated: true)
    }
}
