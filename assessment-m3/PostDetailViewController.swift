
import UIKit

class PostDetailViewController: UIViewController {

    private let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("This screen is created programmatically.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Post Details"

        setupDetails()
    }

    // Detail Screen UI

    private func setupDetails() {

        let titleLabel = UILabel()

        titleLabel.text = post.title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0

        let idLabel = UILabel()

        idLabel.text = "Post ID: \(post.id)"
        idLabel.font = .systemFont(ofSize: 14)
        idLabel.textColor = .secondaryLabel

        let userLabel = UILabel()

        userLabel.text = "User ID: \(post.userId)"
        userLabel.font = .systemFont(ofSize: 14)
        userLabel.textColor = .secondaryLabel

        let bodyLabel = UILabel()

        bodyLabel.text = post.body
        bodyLabel.font = .systemFont(ofSize: 17)
        bodyLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            idLabel,
            userLabel,
            bodyLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 22
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -22
            )
        ])
    }
}
