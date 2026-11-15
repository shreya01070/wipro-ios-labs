import UIKit

@MainActor
class ViewController: UIViewController {

    enum ViewState {
        case idle
        case loading
        case success([String])
        case empty
        case failure(String)
    }

    // UI elements
    let statusLabel = UILabel()
    let fetchButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    let spinner = UIActivityIndicatorView(style: .medium)

    // Keeps track of the current fetch operation
    var fetchTask: Task<Void, Never>?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Courses Async Lab"

        setupUI()
        updateUI(for: .idle)
    }

    // Set up the screen and arrange its elements
    func setupUI() {

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 16, weight: .medium)

        fetchButton.setTitle("Fetch Courses", for: .normal)
        fetchButton.addTarget(
            self,
            action: #selector(didTapFetch),
            for: .touchUpInside
        )

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(didTapCancel),
            for: .touchUpInside
        )

        spinner.hidesWhenStopped = true

        // Place all the elements in a vertical stack
        let stack = UIStackView(
            arrangedSubviews: [
                statusLabel,
                spinner,
                fetchButton,
                cancelButton
            ]
        )

        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor,
                constant: 20
            ),
            stack.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }

    @objc func didTapFetch() {

        // Stop the previous request if one is still running
        fetchTask?.cancel()

        // Start fetching the courses asynchronously
        fetchTask = Task {
            updateUI(for: .loading)

            do {
                let courses = try await simulatedFetchCourses()

                // Stop here if the request was cancelled
                try Task.checkCancellation()

                if courses.isEmpty {
                    updateUI(for: .empty)
                } else {
                    updateUI(for: .success(courses))
                }

            } catch is CancellationError {
                print("Course fetching was cancelled.")

            } catch {
                updateUI(for: .failure(error.localizedDescription))
            }
        }
    }

    @objc func didTapCancel() {

        // Cancel the current request
        fetchTask?.cancel()
        fetchTask = nil

        updateUI(for: .failure("Request was cancelled."))
    }

    // Simulate fetching course information from a server
    func simulatedFetchCourses() async throws -> [String] {

        // Wait for a few seconds to simulate network activity
        try await Task.sleep(nanoseconds: 2_500_000_000)

        try Task.checkCancellation()

        // Return different results to test the UI states
        let choice = Int.random(in: 1...3)

        if choice == 1 {
            throw NSError(
                domain: "NetworkError",
                code: 500,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Failed to connect to server."
                ]
            )
        }

        if choice == 2 {
            return []
        }

        return [
            "SwiftUI Masterclass",
            "Advanced Concurrency",
            "iOS Architectures",
            "Combine Framework"
        ]
    }

    // Display the appropriate message based on the current state
    func updateUI(for state: ViewState) {

        switch state {

        case .idle:
            statusLabel.text = "Tap 'Fetch Courses' to start."
            spinner.stopAnimating()
            fetchButton.isEnabled = true
            cancelButton.isHidden = true

        case .loading:
            statusLabel.text = "Fetching courses..."
            spinner.startAnimating()
            fetchButton.isEnabled = false
            cancelButton.isHidden = false

        case .success(let courses):
            statusLabel.text = "Loaded Courses:\n• " +
                courses.joined(separator: "\n• ")
            spinner.stopAnimating()
            fetchButton.isEnabled = true
            cancelButton.isHidden = true

        case .empty:
            statusLabel.text = "No courses found."
            spinner.stopAnimating()
            fetchButton.isEnabled = true
            cancelButton.isHidden = true

        case .failure(let message):
            statusLabel.text = message
            spinner.stopAnimating()
            fetchButton.isEnabled = true
            cancelButton.isHidden = true
        }
    }
}
