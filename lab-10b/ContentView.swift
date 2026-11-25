
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var eventDate = Date()
    @State private var receiveUpdates = false

    @State private var message = ""
    @State private var registrationSuccessful = false

    var body: some View {

        NavigationStack {
            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    // Header

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Event Registration")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Fill in your details to register for the event.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Personal Details

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Personal Details")
                            .font(.headline)

                        TextField("Enter your full name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.name)
                            .accessibilityIdentifier("registration.name")

                        TextField("Enter your email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .accessibilityIdentifier("registration.email")
                    }

                    // Event Details

                    VStack(alignment: .leading, spacing: 15) {

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

                    Button(action: submitRegistration) {

                        Text("Submit Registration")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("registration.submit")

                    // Feedback Message

                    if !message.isEmpty {

                        Text(message)
                            .font(.subheadline)
                            .foregroundColor(
                                registrationSuccessful ? .green : .red
                            )
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
        }
    }

    // Registration Validation

    private func submitRegistration() {

        let cleanedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let cleanedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedName.isEmpty else {
            showError("Please enter your name.")
            return
        }

        guard isValidEmail(cleanedEmail) else {
            showError("Please enter a valid email address.")
            return
        }

        registrationSuccessful = true
        message = "Registration successful! Thank you, \(cleanedName)."
    }

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

    private func showError(_ text: String) {
        registrationSuccessful = false
        message = text
    }
}
