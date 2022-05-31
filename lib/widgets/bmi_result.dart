import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/generated/l10n.dart';
import 'package:bmi_calculator/theme.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).result_title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _calculateBMI(context.select((BMIModel m) => m.height),
                    context.select((BMIModel m) => m.weight)),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: _calculateColor(
                        context.select((BMIModel m) => m.gender),
                        context.select((BMIModel m) => m.age),
                        context.select((BMIModel m) => m.height),
                        context.select((BMIModel m) => m.weight)))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).weight_range,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _calculateWeightRange(
                    context.select((BMIModel m) => m.gender),
                    context.select((BMIModel m) => m.age),
                    context.select((BMIModel m) => m.height),
                    context.select((BMIModel m) => m.weightUnit)),
                style: Theme.of(context).textTheme.headline5),
          ],
        )
      ],
    );
  }
}

String _calculateBMI(num height, num weight) {
  if (height == 0 || weight == 0) return "-----";
  num index = weight / pow(height / 100, 2);
  if (index > 100) return ">100";
  return (index).toStringAsFixed(1);
}

String _calculateWeightRange(
    bool gender, int age, num height, String? weightUnit) {
  if (age == 0 || height < 10) {
    return "-----";
  }
  num? minWeight;
  num? maxWeight;
  if (age > 17) {
    minWeight = weightRank_1 * pow(height / 100, 2);
    maxWeight = (weightRank_2 - 0.1) * pow(height / 100, 2);
  } else if (gender) {
    minWeight = maleMap[age]!.lack * pow(height / 100, 2);
    maxWeight = (maleMap[age]!.excess - 0.1) * pow(height / 100, 2);
  } else {
    minWeight = femaleMap[age]!.lack * pow(height / 100, 2);
    maxWeight = (femaleMap[age]!.excess - 0.1) * pow(height / 100, 2);
  }
  if (weightUnit == "kg")
    return "${minWeight.toStringAsFixed(1)}-${maxWeight.toStringAsFixed(1)} kg";
  else if (weightUnit == "lb")
    return "${(minWeight / 0.45359293319936).toStringAsFixed(1)}-${(maxWeight / 0.45359293319936).toStringAsFixed(1)} lb";
  return "${(minWeight / 6.35029318).toStringAsFixed(1)}-${(maxWeight / 6.35029318).toStringAsFixed(1)} st";
}

Color? _calculateColor(bool gender, int age, num height, num weight) {
  if (age == 0 || height < 10 || weight == 0) return null;
  num? minWeight;
  num? maxWeight;
  if (age > 17) {
    minWeight = weightRank_1 * pow(height / 100, 2);
    maxWeight = (weightRank_2 - 0.1) * pow(height / 100, 2);
    if (weight < minWeight)
      return lack;
    else if (weight > maxWeight)
      return obesity;
    else
      return normal;
  }
  if (gender) {
    minWeight = maleMap[age]!.lack * pow(height / 100, 2);
    maxWeight = (maleMap[age]!.excess - 0.1) * pow(height / 100, 2);
    if (weight < minWeight)
      return lack;
    else if (weight > maxWeight)
      return obesity;
    else
      return normal;
  }
  minWeight = femaleMap[age]!.lack * pow(height / 100, 2);
  maxWeight = (femaleMap[age]!.excess - 0.1) * pow(height / 100, 2);
  if (weight < minWeight)
    return lack;
  else if (weight > maxWeight)
    return obesity;
  else
    return normal;
}
