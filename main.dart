import 'dart:io';

void main() {
  List<Map<String, dynamic>> students = [];
  Set<String> studentIds = {};

  print("Student Record Management System");

  while (true) {
    stdout.write("Enter student name (or 'exit' to finish): ");
    String name = stdin.readLineSync()!;
    if (name.toLowerCase() == 'exit') break;

    stdout.write("Enter student ID: ");
    String id = stdin.readLineSync()!;
    if (studentIds.contains(id)) {
      print("ID already exists! Please enter a unique ID.\n");
      continue;
    }


    List<String> subjects = ['Bangla', 'Math', 'English', 'ICT', 'Science'];


    Map<String, String> grades = {};
    double totalValue = 0;

    for (var subject in subjects) {
      double mark = getScore(subject);
      String grade = getGrade(mark);
      double value = gradeToValue(grade);
      grades[subject] = grade;
      totalValue += value;
    }


    double averageValue = totalValue / subjects.length;


    String finalGrade = valueToGrade(averageValue);


    students.add({
      'name': name,
      'id': id,
      'grades': grades,
      'averageValue': averageValue,
      'finalGrade': finalGrade,
    });
    studentIds.add(id);

    print("✅ Student record added!\n");
  }

  print("\n===== Student Summary =====");
  if (students.isEmpty) {
    print("No records found!");
    return;
  }

  students.sort((a, b) => b['averageValue'].compareTo(a['averageValue']));

  print("\n📋 Sorted Student List (High → Low):");
  for (var s in students) {
    print(
        "Name: ${s['name']}, ID: ${s['id']}, Final Grade: ${s['finalGrade']} (${s['averageValue'].toStringAsFixed(2)})");
  }

  print("\n👨‍🎓 Total Students: ${students.length}");

  double highest = students.first['averageValue'];
  double lowest = students.last['averageValue'];

  print("Highest Average Grade Value: ${highest.toStringAsFixed(2)}");
  print("Lowest Average Grade Value: ${lowest.toStringAsFixed(2)}");
}

double getScore(String subject) {
  while (true) {
    stdout.write("Enter $subject mark (0–100): ");
    String? input = stdin.readLineSync();
    try {
      double mark = double.parse(input!);
      if (mark < 0 || mark > 100) {
        print("Invalid input! Please enter 0–100.");
      } else {
        return mark;
      }
    } catch (e) {
      print("Please enter a valid number!");
    }
  }
}

String getGrade(double mark) {
  if (mark >= 80) return 'A+';
  if (mark >= 70) return 'A';
  if (mark >= 60) return 'B';
  if (mark >= 50) return 'C';
  if (mark >= 33) return 'D';
  return 'F';
}

double gradeToValue(String grade) {
  switch (grade) {
    case 'A+':
      return 80;
    case 'A':
      return 70;
    case 'B':
      return 60;
    case 'C':
      return 50;
    case 'D':
      return 33;
    default:
      return 32;
  }
}

String valueToGrade(double value) {
  if (value >= 80) return 'A+';
  if (value >= 70) return 'A';
  if (value >= 60) return 'B';
  if (value >= 50) return 'C';
  if (value >= 33) return 'D';
  return 'F';
}
