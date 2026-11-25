
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // UI Controls

    private let nameTextField = UITextField()
    private let enrollmentSwitch = UISwitch()
    private let courseSegment = UISegmentedControl(
        items: ["iOS", "Android", "Web"]
    )
    private let attendanceSlider = UISlider()

    private let summaryLabel = UILabel()

    private let updateButton = UIButton(type: .system)
    private let nextScreenButton = UIButton(type: .system)

    private let scrollView = UIScrollView()
    private let mainStack = UIStackView()

    // View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad: View is loaded")

        title = "Student Registration"
        view.backgroundColor = .systemBackground

        setupUI()
        setupKeyboardHandling()
        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("viewWillAppear: View is about to appear")

        // Refresh the summary whenever this screen becomes visible.
        updateSummary()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear: View is now visible")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("viewWillDisappear: View is about to disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("viewDidDisappear: View is no longer visible")
    }

    // UI Setup

    private func setupUI() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])

        mainStack.axis = .vertical
        mainStack.spacing = 22
        mainStack.alignment = .fill

        mainStack.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 25
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 22
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -22
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -25
            ),

            mainStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -44
            )
        ])

        addNameField()
        addEnrollmentControl()
        addCourseControl()
        addAttendanceControl()
        addSummaryPanel()
        addButtons()
    }

    //Name Text Field

    private func addNameField() {

        let heading = makeHeading("Student Name")

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocapitalizationType = .words
        nameTextField.returnKeyType = .done
        nameTextField.delegate = self

        nameTextField.addTarget(
            self,
            action: #selector(controlValueChanged),
            for: .editingChanged
        )

        mainStack.addArrangedSubview(heading)
        mainStack.addArrangedSubview(nameTextField)
    }

    // Enrollment Switch

    private func addEnrollmentControl() {

        let heading = makeHeading("Enrollment Status")

        enrollmentSwitch.isOn = true

        enrollmentSwitch.addTarget(
            self,
            action: #selector(controlValueChanged),
            for: .valueChanged
        )

        let switchRow = UIStackView()

        switchRow.axis = .horizontal
        switchRow.alignment = .center
        switchRow.distribution = .equalSpacing

        let statusLabel = UILabel()
        statusLabel.text = "Currently Enrolled"
        statusLabel.font = .systemFont(ofSize: 16)

        switchRow.addArrangedSubview(statusLabel)
        switchRow.addArrangedSubview(enrollmentSwitch)

        mainStack.addArrangedSubview(heading)
        mainStack.addArrangedSubview(switchRow)
    }

    // Course Selection

    private func addCourseControl() {

        let heading = makeHeading("Choose Course")

        courseSegment.selectedSegmentIndex = 0

        courseSegment.addTarget(
            self,
            action: #selector(controlValueChanged),
            for: .valueChanged
        )

        mainStack.addArrangedSubview(heading)
        mainStack.addArrangedSubview(courseSegment)
    }

    // Attendance Slider

    private func addAttendanceControl() {

        let heading = makeHeading("Attendance Percentage")

        attendanceSlider.minimumValue = 0
        attendanceSlider.maximumValue = 100
        attendanceSlider.value = 75

        attendanceSlider.addTarget(
            self,
            action: #selector(controlValueChanged),
            for: .valueChanged
        )

        mainStack.addArrangedSubview(heading)
        mainStack.addArrangedSubview(attendanceSlider)
    }

    // Summary Panel

    private func addSummaryPanel() {

        let heading = makeHeading("Student Summary")

        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 16)
        summaryLabel.textColor = .label

        let summaryBox = UIView()

        summaryBox.backgroundColor = .secondarySystemBackground
        summaryBox.layer.cornerRadius = 12

        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        summaryBox.addSubview(summaryLabel)

        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(
                equalTo: summaryBox.topAnchor,
                constant: 16
            ),

            summaryLabel.leadingAnchor.constraint(
                equalTo: summaryBox.leadingAnchor,
                constant: 16
            ),

            summaryLabel.trailingAnchor.constraint(
                equalTo: summaryBox.trailingAnchor,
                constant: -16
            ),

            summaryLabel.bottomAnchor.constraint(
                equalTo: summaryBox.bottomAnchor,
                constant: -16
            )
        ])

        mainStack.addArrangedSubview(heading)
        mainStack.addArrangedSubview(summaryBox)
    }

    //  Buttons

    private func addButtons() {

        updateButton.setTitle("Update Summary", for: .normal)
        updateButton.titleLabel?.font = .boldSystemFont(ofSize: 17)

        updateButton.backgroundColor = .systemBlue
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.layer.cornerRadius = 10

        updateButton.heightAnchor.constraint(
            equalToConstant: 48
        ).isActive = true

        updateButton.addTarget(
            self,
            action: #selector(updateButtonTapped),
            for: .touchUpInside
        )

        nextScreenButton.setTitle(
            "Open Next Screen",
            for: .normal
        )

        nextScreenButton.titleLabel?.font = .systemFont(ofSize: 16)

        nextScreenButton.addTarget(
            self,
            action: #selector(openNextScreen),
            for: .touchUpInside
        )

        mainStack.addArrangedSubview(updateButton)
        mainStack.addArrangedSubview(nextScreenButton)
    }

    // Helper Method

    private func makeHeading(_ title: String) -> UILabel {

        let label = UILabel()

        label.text = title
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label

        return label
    }

    // Control Actions

    @objc private func controlValueChanged() {
        updateSummary()
    }

    @objc private func updateButtonTapped() {

        updateSummary()

        // Hide the keyboard after updating the form.
        view.endEditing(true)
    }

    // Update Summary

    private func updateSummary() {

        let studentName = nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let displayedName = studentName?.isEmpty == false
            ? studentName!
            : "Not entered"

        let enrollmentStatus = enrollmentSwitch.isOn
            ? "Enrolled"
            : "Not Enrolled"

        let selectedCourse: String

        switch courseSegment.selectedSegmentIndex {
        case 0:
            selectedCourse = "iOS Development"

        case 1:
            selectedCourse = "Android Development"

        case 2:
            selectedCourse = "Web Development"

        default:
            selectedCourse = "Not selected"
        }

        let attendance = Int(attendanceSlider.value)

        summaryLabel.text = """
        Name: \(displayedName)

        Enrollment: \(enrollmentStatus)

        Course: \(selectedCourse)

        Attendance: \(attendance)%
        """
    }

    // Navigation

    @objc private func openNextScreen() {

        view.endEditing(true)

        let nextScreen = LifecycleInfoViewController()

        navigationController?.pushViewController(
            nextScreen,
            animated: true
        )
    }

    // Text Field Keyboard

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    // Keyboard Handling

    private func setupKeyboardHandling() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillChangeFrame(
        _ notification: Notification
    ) {

        guard
            let keyboardFrame = notification.userInfo?[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect
        else {
            return
        }

        let convertedFrame = view.convert(
            keyboardFrame,
            from: nil
        )

        let keyboardHeight = max(
            0,
            view.bounds.maxY - convertedFrame.minY
        )

        let duration = notification.userInfo?[
            UIResponder.keyboardAnimationDurationUserInfoKey
        ] as? Double ?? 0.25

        UIView.animate(withDuration: duration) {

            self.scrollView.contentInset.bottom = keyboardHeight
            self.scrollView.scrollIndicatorInsets.bottom = keyboardHeight
        }
    }

    @objc private func keyboardWillHide(
        _ notification: Notification
    ) {

        let duration = notification.userInfo?[
            UIResponder.keyboardAnimationDurationUserInfoKey
        ] as? Double ?? 0.25

        UIView.animate(withDuration: duration) {

            self.scrollView.contentInset.bottom = 0
            self.scrollView.scrollIndicatorInsets.bottom = 0
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
