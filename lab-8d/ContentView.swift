
import SwiftUI

struct ContentView: View {

    // Form Details

    @State private var fullName = ""
    @State private var email = ""
    @State private var phoneNumber = ""

    @State private var selectedEvent = ""
    @State private var eventDate = Date()

    @State private var receiveUpdates = false
    @State private var additionalInfo = ""

    @State private var showSuccess = false

    private let events = [
        "iOS Development Workshop",
        "SwiftUI Bootcamp",
        "Mobile App Development",
        "Technology Conference",
        "Coding Competition"
    ]

    // Validation

    private var isEmailValid: Bool {

        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: pattern,
            options: .regularExpression
        ) != nil
    }

    private var isPhoneValid: Bool {

        let digits = phoneNumber.filter { $0.isNumber }

        return digits.count >= 10
    }

    private var isFormValid: Bool {

        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isEmailValid &&
        isPhoneValid &&
        !selectedEvent.isEmpty
    }

    var body: some View {

        NavigationStack {

            Form {

                // Personal Information

                Section(header: Text("Personal Information")) {

                    TextField("Enter your full name", text: $fullName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)

                    TextField("Enter your email address", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    if !email.isEmpty && !isEmailValid {

                        Text("Please enter a valid email address.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)

                    if !phoneNumber.isEmpty && !isPhoneValid {

                        Text("Please enter at least 10 digits.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                // Event Details

                Section(header: Text("Event Details")) {

                    Picker("Select Event", selection: $selectedEvent) {

                        Text("Choose an event")
                            .tag("")

                        ForEach(events, id: \.self) { event in

                            Text(event)
                                .tag(event)
                        }
                    }

                    DatePicker(
                        "Event Date",
                        selection: $eventDate,
                        in: Date()...,
                        displayedComponents: .date
                    )

                    Toggle(
                        "Receive event updates",
                        isOn: $receiveUpdates
                    )
                }

                // Additional Information

                Section(header: Text("Additional Information")) {

                    TextEditor(text: $additionalInfo)
                        .frame(minHeight: 100)

                    Text("\(additionalInfo.count) characters")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                // Submit

                Section {

                    Button {

                        showSuccess = true

                    } label: {

                        Text("Submit Registration")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!isFormValid)
                    .foregroundColor(.white)
                    .listRowBackground(
                        isFormValid ? Color.blue : Color.gray.opacity(0.4)
                    )

                    if !isFormValid {

                        Text("Please complete all required fields correctly.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Event Registration")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)

            // Success Alert

            .alert(
                "Registration Successful!",
                isPresented: $showSuccess
            ) {

                Button("OK", role: .cancel) { }

            } message: {

                Text("Thank you, \(fullName)! Your registration for \(selectedEvent) has been received.")
            }
        }
    }
}

#Preview {
    ContentView()
}
