import 'package:flutter/material.dart';

import '../../../models/JsonQuestionParser.dart';

Widget multipleChoiceQuestionTwoWidget({
  required Question question,
  required Function function,
  required int index,
  required List<int> selectedVal,
}) {
  return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Text(
          question.question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      ...List.generate(question.answers.length, (i) {
        return CheckboxListTile(
          title: Text(
            question.answers[i],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          activeColor: Colors.white,
          value: selectedVal[i] == -1234567890123411123 ? false : true,
          onChanged: (val) {
            if (selectedVal[i] == -1234567890123411123) {
              function(i, index, -1);
            } else {
              function(-1234567890123411123, index, i);
            }
          },
        );
      }).toList(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          'More than one answer can be correct. Select all correct answers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      )
    ],
  );
}
