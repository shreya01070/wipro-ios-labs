
import SwiftUI

// Registration Fields

enum RegistrationField: Hashable {
    case name
    case email
}

// Content View

struct ContentView: View {

    // Form State

    @State private var name = ""
    @State private var email = ""
    @State private var eventDate = Date()
    @State private var receiveUpdates = false

    @State private var message = ""
    @State private var registrationSuccessful = false

    @FocusState private var focusedField: RegistrationField?

    var body: some View {

        NavigationStack {
            ScrollView {

                VStack(alignment: .leading, spacing: 24) {

                    //  Header

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Event Registration")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Enter your details to register for the event.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Personal Details

                    VStack(alignment: .leading, spacing: 14) {

                        Text("Personal Details")
                            .font(.headline)

                        TextField("Enter your full name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .focused($focusedField, equals: .name)
                            .accessibilityIdentifier("registration.name")

                        TextField("Enter your email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusedField, equals: .email)
                            .accessibilityIdentifier("registration.email")
                    }

                    // Event Details

                    VStack(alignment: .leading, spacing: 16) {

                        Text("Event Details")
                            .font(.headline)

                        DatePicker(
                            "Select event date",
                            selection: $eventDate,
                            in: Date()...,
                            displayedComponents: .date
                        )
                        .accessibilityIdentifier("registration.date")

                        Toggle(
                            "Receive event updates",
                            isOn: $receiveUpdates
                        )
                        .accessibilityIdentifier("registration.updates")
                    }

                    // Submit Button

                    Button {
                        submitRegistration()
                    } label: {

                        Text("Submit Registration")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("registration.submit")

                    // Feedback

                    if !message.isEmpty {

                        Text(message)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(
                                registrationSuccessful ? .green : .red
                            )
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier(
                                registrationSuccessful
                                ? "registration.success"
                                : "registration.error"
                            )
                    }
                }
                .padding()
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)

            // Keyboard Toolbar

            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()

                    Button("Done") {
                        focusedField = nil
                    }
                    .accessibilityIdentifier(
                        "registration.keyboard.done"
                    )
                }
            }
        }
    }

    // Registration Logic

    private func submitRegistration() {

        focusedField = nil

        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Check whether the name is entered.
        guard !cleanedName.isEmpty else {
            showError("Please enter your name.")
            return
        }

        // Check whether the email is valid.
        guard isValidEmail(cleanedEmail) else {
            showError("Please enter a valid email address.")
            return
        }

        // Registration completed successfully.
        registrationSuccessful = true
        message = "Registration successful! Thank you, \(cleanedName)."
    }

    // Email Validation

    private func isValidEmail(_ email: String) -> Bool {

        let parts = email.split(
            separator: "@",
            omittingEmptySubsequences: false
        )

        guard parts.count == 2,
              !parts[0].isEmpty,
              !parts[1].isEmpty,
              !email.contains(" "),
              parts[1].contains(".") else {

            return false
        }

        return true
    }

    // Error Handling

    private func showError(_ text: String) {

        registrationSuccessful = false
        message = text
    }
}

