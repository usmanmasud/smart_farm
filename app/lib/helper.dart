import 'dart:math'; // Ensure this is needed; if not, remove it.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for text styling.

class Helper extends StatefulWidget {
  const Helper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HelperState();
  }
}

class HelperState extends State<Helper> {
  int typeOfCrop = 0, soilType = 0, pesticideUse = 0, pesticideCount = 0;
  double pesticideWeek = 0;
  int currentStep = 1;
  bool isLoading = false, result = false;
  int ans = 0;

  Future<int> getData() async {
    // Simulate fetching data with a delay.
    await Future.delayed(const Duration(seconds: 2));
    return Random().nextInt(100); // Simulated response.
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = [
      buildQuestion(
        questionText: 'What Type of Crop are you growing?',
        dropdownValue: typeOfCrop,
        dropdownItems: const [
          DropdownMenuItem(value: 0, child: Text("Food Crops")),
          DropdownMenuItem(value: 1, child: Text("Cash Crops")),
        ],
        onChanged: (int? value) => setState(() => typeOfCrop = value!),
        onPressedNext: () => setState(() => currentStep = 2),
      ),
      buildQuestion(
        questionText: 'What Type of Soil are you using?',
        dropdownValue: soilType,
        dropdownItems: const [
          DropdownMenuItem(value: 0, child: Text("Alluvial Soil")),
          DropdownMenuItem(value: 1, child: Text("Others (Red, Black, etc.)")),
        ],
        onChanged: (int? value) => setState(() => soilType = value!),
        onPressedNext: () => setState(() => currentStep = 3),
      ),
      buildQuestion(
        questionText: 'Do you use pesticides?',
        dropdownValue: pesticideUse,
        dropdownItems: const [
          DropdownMenuItem(value: 0, child: Text("Never")),
          DropdownMenuItem(value: 1, child: Text("Previously Used")),
          DropdownMenuItem(value: 2, child: Text("Currently Using")),
        ],
        onChanged: (int? value) => setState(() => pesticideUse = value!),
        onPressedNext: () => setState(() => currentStep = 4),
      ),
      buildTextInputQuestion(
        questionText: 'Pesticide count in a week? (0-100)',
        onTextChanged: (value) {
          try {
            pesticideCount = int.parse(value);
          } catch (e) {
            pesticideCount = 0; // Handle invalid input gracefully.
          }
        },
        onPressedNext: () => setState(() => currentStep = 5),
      ),
      buildTextInputQuestion(
        questionText: 'How many weeks did you use pesticide?',
        onTextChanged: (value) {
          try {
            pesticideWeek = double.parse(value);
          } catch (e) {
            pesticideWeek = 0.0; // Handle invalid input gracefully.
          }
        },
        onPressedNext: () async {
          setState(() => isLoading = true);
          ans = await getData();
          setState(() {
            result = true;
            isLoading = false;
          });
        },
        buttonLabel: 'Submit',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.green,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : !result
              ? Column(
                  children: [
                    buildHeader(context),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40)),
                        ),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: currentStep,
                          itemBuilder: (context, index) {
                            return questions[index];
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'Result: $ans',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 24),
                  ),
                ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return SizedBox(
      height: 275,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 90, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/kisan_helper.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              'Smart Farm',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion({
    required String questionText,
    required int dropdownValue,
    required List<DropdownMenuItem<int>> dropdownItems,
    required ValueChanged<int?> onChanged,
    required VoidCallback onPressedNext,
    String buttonLabel = 'OK',
  }) {
    return Column(
      children: [
        buildQuestionHeader(questionText),
        Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButton<int>(
            value: dropdownValue,
            items: dropdownItems,
            onChanged: onChanged,
          ),
        ),
        ElevatedButton(onPressed: onPressedNext, child: Text(buttonLabel)),
      ],
    );
  }

  Widget buildTextInputQuestion({
    required String questionText,
    required ValueChanged<String> onTextChanged,
    required VoidCallback onPressedNext,
    String buttonLabel = 'OK',
  }) {
    return Column(
      children: [
        buildQuestionHeader(questionText),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: onTextChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter value',
            ),
          ),
        ),
        ElevatedButton(onPressed: onPressedNext, child: Text(buttonLabel)),
      ],
    );
  }

  Widget buildQuestionHeader(String text) {
    return Row(
      children: [
        const SizedBox(width: 5),
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/kisan_helper.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
