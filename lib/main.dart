import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculateur d\'âge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // ignore: deprecated_member_use
        backgroundColor: const Color.fromARGB(255, 89, 107, 122),
      ),
      home: const AgeCalculator(),
    );
  }
}

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  late DateTime selectedDate = DateTime.now();
  String age = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        calculateAge();
      });
    }
  }

  void calculateAge() {
    if (selectedDate != null) {
      final now = DateTime.now();
      final difference = now.difference(selectedDate);
      final ageInYears = (difference.inDays / 365).floor();
      setState(() {
        age = 'Votre âge est de $ageInYears ans.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Color.fromARGB(255, 178, 182, 242),
      appBar: AppBar(
        title: const Text('Calculateur d\'âge'),
        backgroundColor : const Color.fromARGB(255, 17, 89, 147)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          

            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                selectedDate == null
                    ? 'Sélectionner une date de naissance'
                    : 'Changer la date de naissance',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedDate == null
                  ? 'Aucune date sélectionnée.'
                  : 'Date sélectionnée : ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
            ),
            const SizedBox(height: 20),
            Text(
              age,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
