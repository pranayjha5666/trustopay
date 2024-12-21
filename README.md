# TrustoPay

This application provides a user-friendly interface to track and manage contract milestones, ensuring payments are processed step-by-step. The task demonstrates Flutter's capabilities in managing dynamic UI components, such as steppers and dialogs, to create a robust contract tracking system.

---

## Implementation Details

### Core Features:
1. **Dynamic Stepper UI**:
   - A `Stepper` widget is used to display contract milestones dynamically based on the fetched API data.
   - Each step represents a milestone, with details such as the title, amount, due date, and description.

2. **Payment Confirmation Dialog**:
   - Before marking a milestone as completed, a confirmation dialog appears to ensure user intent.
   - The dialog displays the amount and prompts for confirmation, improving user safety for payment actions.

3. **Milestone Completion Tracking**:
   - The stepper updates in real-time as milestones are completed.
   - Upon completing all milestones, the stepper is replaced with a summary of completed milestone titles.

4. **Error Handling**:
   - Checks for null or missing milestone fields, ensuring the app handles incomplete or malformed data gracefully.

5. **Seamless Navigation**:
   - Users can move between milestones and revisit previous steps unless payment for a milestone has been completed.

6. **Responsive UI**:
   - Ensures compatibility across different device screen sizes and orientations.

---

## Steps to Install and Run the Project

### Prerequisites:
1. Ensure you have Flutter installed on your system. If not, follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install).
2. Install a code editor such as Visual Studio Code or Android Studio.

### Installation:
1. Clone this repository:
   ```bash
   git clone https://github.com/pranayjha5666/trustopay.git
   ```
2. Navigate to the project directory:
   ```bash
   cd trustopay
   ```
3. Fetch the dependencies:
   ```bash
   flutter pub get
   ```

### Running the Project:
1. Connect a physical device or start an emulator.
2. Run the application:
   ```bash
   flutter run
   ```

---

## Directory Structure
```
trustopay/
├── lib/
│   Services/
│      ├── fetchdata.dart
│   widget/
│      ├── contract_details.dart
│      ├── project_milestones.dart
│      ├── seller_payment.dart
│      ├── top_area.dart
│   ├── home_page.dart       # Contains the implementation Home Page 
│   ├── main.dart                # Entry point of the application
├── pubspec.yaml                 # Project dependencies
```

---

## Additional Notes
- This project demonstrates the use of Flutter widgets like `Stepper`, `AlertDialog`, and dynamic rendering based on API data.
- Feel free to fork this repository and modify the app for your own use cases.

---


