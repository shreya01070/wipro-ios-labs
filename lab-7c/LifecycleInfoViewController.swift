import UIKit

class LifecycleInfoViewController: UIViewController {

    private let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Next Screen: viewDidLoad")

        title = "Lifecycle Information"
        view.backgroundColor = .systemBackground

        setupScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Next Screen: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Next Screen: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Next Screen: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("Next Screen: viewDidDisappear")
    }

    private func setupScreen() {

        messageLabel.text = """
        Welcome to the next screen!

        You have successfully navigated
        from the Student Registration screen.

        Use the back button to return.
        """

        messageLabel.font = .systemFont(ofSize: 19)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(messageLabel)

        NSLayoutConstraint.activate([

            messageLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            messageLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            messageLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])
    }
}
