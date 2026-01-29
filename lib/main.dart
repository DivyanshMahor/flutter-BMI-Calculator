
// Imports the material.dart package, which contains widgets and tools for Material Design.
import 'package:flutter/material.dart';

// The main function is the entry point for all Flutter applications.
void main() {
  // runApp() inflates the given widget and attaches it to the screen.
  runApp(const MyBmiApp());
}

// MyBmiApp is a StatelessWidget, meaning it describes part of the user interface
// which can't change over time.
class MyBmiApp extends StatelessWidget {
  // The constructor for MyBmiApp. The key is passed to the parent (StatelessWidget) constructor.
  const MyBmiApp({super.key});

  // This build() method describes how to display the widget in terms of other, lower-level widgets.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a convenience widget that wraps a number of widgets that are
    // commonly required for Material Design applications.
    return MaterialApp(
      title: 'Flutter Demo', // The application's title, used by the operating system.
      theme: ThemeData(
        // Defines the application's color scheme.
        colorScheme: ColorScheme.fromSeed(
          // fromSeed creates a complete color scheme from a single seed color.
          seedColor: const Color.fromARGB(255, 94, 10, 238),
        ),
      ),
      // 'home' is the default route of the app, the widget that is displayed first.
      home: const MyHomePage(title: 'BMI Calculator'),
      // Hides the "debug" banner in the top-right corner.
      debugShowCheckedModeBanner: false,
    );
  }
}

// MyHomePage is a StatefulWidget, which means it has mutable state.
class MyHomePage extends StatefulWidget {
  // Constructor for MyHomePage, it requires a title.
  const MyHomePage({super.key, required this.title});

  // The title for the AppBar, it's final because this widget itself is immutable.
  final String title;

  // Creates the mutable state object for this StatefulWidget.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// _MyHomePageState holds the state for MyHomePage. The logic and internal state goes here.
class _MyHomePageState extends State<MyHomePage> {
  // Controllers for the text fields to get/set their text.
  var wtController = TextEditingController(); // Controller for weight
  var ftController = TextEditingController(); // Controller for height in feet
  var inController = TextEditingController(); // Controller for height in inches

  // Variables to hold the state that changes.
  var bgColor; // Background color that changes based on the BMI result.
  var msg = " "; // Message indicating if the user is underweight, overweight, or healthy.
  var result = ""; // The final BMI calculation result displayed on the screen.

  // The build method for the state, it's re-run every time we call setState().
  @override
  Widget build(BuildContext context) {
    // Scaffold implements the basic Material Design visual layout structure.
    return Scaffold(
      appBar: AppBar(
        // The background color of the AppBar, using the theme's color scheme.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // The title displayed in the AppBar, taken from the MyHomePage widget.
        title: Text(widget.title),
      ),
      // The main body of the application.
      body: Container(
        color: bgColor, // Sets the background color of the container.
        child: Center( // Centers its child widget.
          child: Container(
            color: const Color.fromARGB(10, 180, 177, 188), // A subtle background color for the card.
            height: 500, // Fixed height for the inner container.
            width: 300,  // Fixed width for the inner container.
            child: Column( // Arranges its children in a vertical column.
              children: [
                // Main title on the card.
                Text(
                  "BMI",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                // Text field for the user to enter their weight.
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    label: Text("Enter your weight (in KGs)"), // Label for the text field.
                    prefixIcon: Icon(Icons.line_weight), // Icon at the start of the text field.
                  ),
                  keyboardType: TextInputType.number, // Shows a numeric keyboard.
                ),

                // Text field for height in feet.
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    label: Text("Enter your height (in Feet)"),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),

                // Text field for height in inches.
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                    label: Text("Enter your height (in Inch)"),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 22), // An invisible box to create vertical space.

                // Button the user presses to calculate the BMI.
                ElevatedButton(
                  onPressed: () {
                    // Get the text from the controllers.
                    var wt = wtController.text;
                    var ft = ftController.text;
                    var inch = inController.text;

                    // Check that all fields are filled.
                    if (wt != "" && ft != "" && inch != "") {
                      // Convert the text to integer numbers.
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iInch = int.parse(inch);

                      // BMI calculation logic:
                      // 1. Convert total height into inches.
                      var tInch = (ift * 12) + iInch;
                      // 2. Convert total height into centimeters.
                      var tCm = tInch * 2.54;
                      // 3. Convert total height into meters.
                      var tm = tCm / 100;
                      // 4. Calculate BMI.
                      var bmi = iwt / (tm * tm);

                      // Determine the message and background color based on the BMI value.
                      if (bmi > 25) {
                        msg = "You are OverWeight";
                        bgColor = Colors.orange.shade200;
                      } else if (bmi < 18) {
                        msg = "You are UnderWeight";
                        bgColor = Colors.blueGrey.shade200;
                      } else {
                        msg = "You are Healthy";
                        bgColor = Colors.green.shade200;
                      }

                      // Call setState() to notify Flutter that the state has changed,
                      // so it can re-run the build method and update the UI.
                      setState(() {
                        result =
                            "$msg Your BMI is : ${bmi.toStringAsFixed(2)}";
                      });

                    } else {
                      // If any field is empty, show an error message.
                      setState(() {
                        result = "Please fill all the required fields";
                      });
                    }
                  },
                  child: Text("Calculate"), // The text inside the button.
                ),

                SizedBox(height: 12), // More vertical space.

                // Display the calculation result.
                Text(
                  result,
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
