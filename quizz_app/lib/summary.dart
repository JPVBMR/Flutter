import 'package:flutter/material.dart';
import 'package:quizz_app/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /* Fixed High (Reduce it to see the scrollView) */
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return SummaryItem(
              itemData: data,
            );
          }).toList(),
        ),
      ),
    );
  }
}
