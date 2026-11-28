
# Course Planner App

# 1. Project Overview

Course Planner is a student academic management
application developed using Swift and SwiftUI.

It helps students organize their courses,
manage assignments, track deadlines and
monitor their academic progress.

# 2. Problem Statement

Students often manage their courses and
assignments using different applications or
manual notes.

This makes it difficult to track deadlines
and monitor completed and pending work.

Course Planner provides a simple centralized
solution for managing academic activities.

# 3. Target Users

- College students
- University students
- Students learning programming
- Students managing multiple courses

# 4. Features

- View academic dashboard
- Add and delete courses
- Add and manage assignments
- Select assignment due dates
- Mark assignments as completed
- Filter pending and completed assignments
- Calculate overall completion percentage
- Validate user input
- Save data locally

# 5. Technologies Used

- Swift
- SwiftUI
- Foundation
- Combine
- UserDefaults
- JSONEncoder and JSONDecoder
- XCTest
- MVVM Architecture

# 6. Project Architecture

The application follows the MVVM architecture.

Model:
Stores course and assignment information.

View:
Displays the application interface.

ViewModel:
Manages application logic and data updates.

Service:
Handles local data storage.

Helper:
Contains reusable validation functions.

# 7. Project Structure

CoursePlanner/
- CoursePlannerApp.swift
- Models/
- Views/
- ViewModels/
- Services/
- Helpers/
- Tests/

# 8. Setup Requirements

- macOS with a compatible Apple development tool
- Swift 5.9 or later
- SwiftUI-compatible environment
- iOS 17 or later deployment target

# 9. Run Instructions

1. Open the project in a compatible
   Apple development environment.
2. Make sure all Swift source files are
   included in the application target.
3. Set the deployment target to iOS 17 or later.
4. Run the application on a supported device
   or simulator.
5. Use the Courses tab to add courses.
6. Use the Assignments tab to manage tasks.

# 10. Testing

The project includes eight XCTest cases
covering course management, assignment
management, input validation, completion
tracking and progress calculation.

# 11. Limitations

- Data is stored locally.
- There is no cloud synchronization.
- There are no push notifications.
- There is no user authentication.
- The application does not currently support
  multiple user accounts.

# 12. Future Improvements

- Assignment reminders
- Calendar integration
- Cloud backup
- Study schedule management
- Course-wise progress reports
