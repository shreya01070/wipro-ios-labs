
import UIKit

class StudentListViewController: UIViewController,
                                 UITableViewDelegate,
                                 UITableViewDataSource {

    private let tableView = UITableView()

    private var students: [Student] = [
        Student(
            name: "Ayan Singh",
            rollNumber: 101,
            course: "Computer Science",
            email: "aman@gmail.com",
            phoneNumber: "9876543210",
            year: "Third Year"
        ),

        Student(
            name: "Riya Sharma",
            rollNumber: 102,
            course: "Information Technology",
            email: "riya@gmail.com",
            phoneNumber: "9876501234",
            year: "Second Year"
        ),

        Student(
            name: "Rahul Singh",
            rollNumber: 103,
            course: "Electronics",
            email: "rahul@gmail.com",
            phoneNumber: "9876512345",
            year: "Fourth Year"
        ),

        Student(
            name: "Neha Gupta",
            rollNumber: 104,
            course: "Computer Science",
            email: "neha@gmail.com",
            phoneNumber: "9876523456",
            year: "First Year"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Student List"
        view.backgroundColor = .systemBackground

        setupTableView()
    }

    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "StudentCell"
        )

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    // Number of rows in the student list
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return students.count
    }

    // Display student names and roll numbers
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "StudentCell",
            for: indexPath
        )

        let student = students[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = student.name
        content.secondaryText = "Roll No: \(student.rollNumber)"

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // Open the detail screen when a student is selected
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedStudent = students[indexPath.row]

        let detailScreen = StudentDetailViewController(
            student: selectedStudent
        )

        navigationController?.pushViewController(
            detailScreen,
            animated: true
        )
    }
}
