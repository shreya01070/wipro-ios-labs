import UIKit

class ViewController: UIViewController {

    // Elements used on the screen
    let statusLabel = UILabel()
    let actionButton = UIButton(type: .system)
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Concurrency Lab"
        setupViews()
    }

    // Set up the label, button and loading indicator
    func setupViews() {

        statusLabel.text = "Press the button to start"
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 16, weight: .medium)

        actionButton.setTitle("Start Download", for: .normal)
        actionButton.titleLabel?.font = .systemFont(
            ofSize: 18,
            weight: .bold
        )

        actionButton.addTarget(
            self,
            action: #selector(didTapStartButton),
            for: .touchUpInside
        )

        spinner.hidesWhenStopped = true

        // Keep all the elements together in a vertical stack
        let stack = UIStackView(
            arrangedSubviews: [statusLabel, actionButton, spinner]
        )

        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func didTapStartButton() {

        // Show that the download has started
        actionButton.isEnabled = false
        actionButton.alpha = 0.5

        spinner.startAnimating()
        statusLabel.text = "Downloading data..."

        // Check which thread is handling the button tap
        print("Button tapped on: \(Thread.current)")

        // Run the download work in the background
        DispatchQueue.global(qos: .userInitiated).async {

            print("Background work started on: \(Thread.current)")

            // Simulate a task that takes some time to finish
            Thread.sleep(forTimeInterval: 3.0)

            let result = "Successfully downloaded 5 items!"

            // Wait one more second before updating the screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                print("Updating UI on: \(Thread.current)")

                // Update the screen on the main thread
                self.statusLabel.text = result

                self.spinner.stopAnimating()
                self.actionButton.isEnabled = true
                self.actionButton.alpha = 1.0
            }
        }
    }
}
