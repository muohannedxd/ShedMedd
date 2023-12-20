import 'package:flutter/material.dart';

import '../constants/customColors.dart';

class EmptyListWidget extends StatelessWidget {
  final String emptyError;
  const EmptyListWidget({super.key, required this.emptyError});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            emptyError,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: CustomColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
