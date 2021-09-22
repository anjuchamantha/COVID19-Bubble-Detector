import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LandingStepProgress extends StatelessWidget {
  final int currentStep;
  const LandingStepProgress({Key? key, required this.currentStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
        totalSteps: 6,
        currentStep: this.currentStep,
        selectedColor: Theme.of(context).primaryColor,
        unselectedColor: Theme.of(context).secondaryHeaderColor);
  }
}
