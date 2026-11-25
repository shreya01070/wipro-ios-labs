
import UIKit

class StudentDetailViewController: UIViewController {

    private let student: Student

    private let nameLabel = UILabel()
    private let rollLabel = UILabel()
    private let courseLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let yearLabel = UILabel()

    // Receive the selected student from the previous screen
    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Student Details"
        view.backgroundColor = .systemBackground

        setupLabels()
        displayStudentDetails()
    }

    private func setupLabels() {

        let labels = [
            nameLabel,
            rollLabel,
            courseLabel,
            emailLabel,
            phoneLabel,
            yearLabel
        ]

        let stackView = UIStackView(arrangedSubviews: labels)

        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])

        labels.forEach { label in
            label.font = .systemFont(ofSize: 18)
            label.textColor = .label
            label.numberOfLines = 0
        }

        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.textColor = .systemBlue
    }

    private func displayStudentDetails() {

        nameLabel.text = "Name: \(student.name)"
        rollLabel.text = "Roll Number: \(student.rollNumber)"
        courseLabel.text = "Course: \(student.course)"
        emailLabel.text = "Email: \(student.email)"
        phoneLabel.text = "Phone: \(student.phoneNumber)"
        yearLabel.text = "Year: \(student.year)"
    }
}
