
import UIKit

class PostsViewController: UIViewController,
                           UITableViewDataSource,
                           UITableViewDelegate {

    private let tableView = UITableView()

    private let activityIndicator =
        UIActivityIndicatorView(style: .large)

    private let statusLabel = UILabel()

    private let retryButton = UIButton(type: .system)

    private let apiService = APIService()

    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Posts"

        setupTableView()
        setupStatusViews()

        fetchPosts()
    }

    //Table View

    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "PostCell"
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }

    // Status Views

    private func setupStatusViews() {

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 16)

        retryButton.setTitle("Try Again", for: .normal)

        retryButton.addTarget(
            self,
            action: #selector(retryLoading),
            for: .touchUpInside
        )

        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        view.addSubview(retryButton)

        NSLayoutConstraint.activate([

            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            statusLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            statusLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            statusLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor,
                constant: 20
            ),

            statusLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -20
            ),

            retryButton.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor,
                constant: 15
            ),

            retryButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])

        statusLabel.isHidden = true
        retryButton.isHidden = true
    }

    // Fetch API Data

    private func fetchPosts() {

        tableView.isHidden = true
        statusLabel.isHidden = true
        retryButton.isHidden = true

        activityIndicator.startAnimating()

        Task {
            do {

                let fetchedPosts = try await apiService.fetchPosts()

                posts = fetchedPosts

                activityIndicator.stopAnimating()

                if posts.isEmpty {
                    showEmptyState()
                } else {
                    showPosts()
                }

            } catch {

                activityIndicator.stopAnimating()
                showFailureState()
            }
        }
    }

    // UI States

    private func showPosts() {

        statusLabel.isHidden = true
        retryButton.isHidden = true

        tableView.isHidden = false
        tableView.reloadData()
    }

    private func showEmptyState() {

        tableView.isHidden = true

        statusLabel.text = "No posts available."
        statusLabel.isHidden = false

        retryButton.isHidden = true
    }

    private func showFailureState() {

        tableView.isHidden = true

        statusLabel.text = """
        Something went wrong.
        Please check your internet connection.
        """

        statusLabel.isHidden = false
        retryButton.isHidden = false
    }

    //  Retry

    @objc private func retryLoading() {

        fetchPosts()
    }

    // Table View Data Source

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return posts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        )

        let post = posts[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = post.title
        content.secondaryText = post.body

        content.secondaryTextProperties.numberOfLines = 2

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // Navigation

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedPost = posts[indexPath.row]

        let detailVC = PostDetailViewController(
            post: selectedPost
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
