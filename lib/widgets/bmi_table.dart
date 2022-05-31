import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/theme.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class BMITable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_WeightCategories(), _WeightIndexes()],
      ),
    );
  }
}

class _WeightCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.select((BMIModel m) => m.age) > 17 ||
        context.select((BMIModel m) => m.age) == 0) {
      return Column(
        children: [
          Text(S.of(context).weight_category_1,
              style: _getYellowTextStyle(context)),
          Text(S.of(context).weight_category_2,
              style: _getGreenTextStyle(context)),
          Text(S.of(context).weight_category_3,
              style: _getRedColor(context, 3)),
          Text(S.of(context).weight_category_4,
              style: _getRedColor(context, 4)),
          Text(S.of(context).weight_category_5,
              style: _getRedColor(context, 5)),
          Text(S.of(context).weight_category_6,
              style: _getRedColor(context, 6)),
        ],
      );
    } else {
      return Column(
        children: [
          Text(S.of(context).weight_category_1,
              style: _getYellowTextStyle(context)),
          Text(S.of(context).weight_category_2,
              style: _getGreenTextStyle(context)),
          Text(S.of(context).weight_category_3,
              style: _getRedColor(context, 1)),
          Text(S.of(context).obesity, style: _getRedColor(context, 2)),
        ],
      );
    }
  }
}

class _WeightIndexes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.select((BMIModel m) => m.age) > 17 ||
        context.select((BMIModel m) => m.age) == 0) {
      return Column(
        children: [
          Text("<$weightRank_1", style: _getYellowTextStyle(context)),
          Text("$weightRank_1 - ${weightRank_2 - 0.1}",
              style: _getGreenTextStyle(context)),
          Text("$weightRank_2 - ${weightRank_3 - 0.1}",
              style: _getRedColor(context, 3)),
          Text("$weightRank_3 - ${weightRank_4 - 0.1}",
              style: _getRedColor(context, 4)),
          Text("$weightRank_4 - ${weightRank_5 - 0.1}",
              style: _getRedColor(context, 5)),
          Text(">$weightRank_5", style: _getRedColor(context, 6)),
        ],
      );
    } else if (context.select((BMIModel m) => m.gender)) {
      WeightRank weightRank = maleMap[context.select((BMIModel m) => m.age)]!;
      return Column(
        children: [
          Text("<${weightRank.lack}", style: _getYellowTextStyle(context)),
          Text(
              "${weightRank.lack} - " +
                  (weightRank.excess - 0.1).toStringAsFixed(1),
              style: _getGreenTextStyle(context)),
          Text(
              "${weightRank.excess} - " +
                  (weightRank.obesity - 0.1).toStringAsFixed(1),
              style: _getRedColor(context, 1)),
          Text(">${weightRank.obesity}", style: _getRedColor(context, 2)),
        ],
      );
    } else {
      WeightRank weightRank = femaleMap[context.select((BMIModel m) => m.age)]!;
      return Column(
        children: [
          Text("<${weightRank.lack}", style: _getYellowTextStyle(context)),
          Text(
              "${weightRank.lack} - " +
                  (weightRank.excess - 0.1).toStringAsFixed(1),
              style: _getGreenTextStyle(context)),
          Text(
              "${weightRank.excess} - " +
                  (weightRank.obesity - 0.1).toStringAsFixed(1),
              style: _getRedColor(context, 1)),
          Text(">${weightRank.obesity}", style: _getRedColor(context, 2)),
        ],
      );
    }
  }
}

TextStyle? _getYellowTextStyle(BuildContext context) {
  int age = context.select((BMIModel m) => m.age);
  num height = context.select((BMIModel m) => m.height);
  num weight = context.select((BMIModel m) => m.weight);
  bool gender = context.select((BMIModel m) => m.gender);
  if (age == 0 || height < 10 || weight == 0) {
    return Theme.of(context).textTheme.bodyText1;
  }
  num? minWeight;
  if (age > 17) {
    minWeight = weightRank_1 * pow(height / 100, 2);
    if (weight < minWeight)
      return Theme.of(context).textTheme.bodyText1!.copyWith(color: lack);
    else
      return Theme.of(context).textTheme.bodyText1;
  }
  if (gender) {
    minWeight = maleMap[age]!.lack * pow(height / 100, 2);
    if (weight < minWeight)
      return Theme.of(context).textTheme.bodyText1!.copyWith(color: lack);
    else
      return Theme.of(context).textTheme.bodyText1;
  }
  minWeight = femaleMap[age]!.lack * pow(height / 100, 2);
  if (weight < minWeight)
    return Theme.of(context).textTheme.bodyText1!.copyWith(color: lack);
  else
    return Theme.of(context).textTheme.bodyText1;
}

TextStyle? _getGreenTextStyle(BuildContext context) {
  int age = context.select((BMIModel m) => m.age);
  num height = context.select((BMIModel m) => m.height);
  num weight = context.select((BMIModel m) => m.weight);
  bool gender = context.select((BMIModel m) => m.gender);
  if (age == 0 || height < 10 || weight == 0)
    return Theme.of(context).textTheme.bodyText1;
  num? minWeight;
  num? maxWeight;
  if (age > 17) {
    minWeight = weightRank_1 * pow(height / 100, 2);
    maxWeight = (weightRank_2 - 0.1) * pow(height / 100, 2);
    if (weight < minWeight)
      return Theme.of(context).textTheme.bodyText1;
    else if (weight > maxWeight)
      return Theme.of(context).textTheme.bodyText1;
    else
      return Theme.of(context).textTheme.bodyText1!.copyWith(color: normal);
  }
  if (gender) {
    minWeight = maleMap[age]!.lack * pow(height / 100, 2);
    maxWeight = (maleMap[age]!.excess - 0.1) * pow(height / 100, 2);
    if (weight < minWeight)
      return Theme.of(context).textTheme.bodyText1;
    else if (weight > maxWeight)
      return Theme.of(context).textTheme.bodyText1;
    else
      return Theme.of(context).textTheme.bodyText1!.copyWith(color: normal);
  }
  minWeight = femaleMap[age]!.lack * pow(height / 100, 2);
  maxWeight = (femaleMap[age]!.excess - 0.1) * pow(height / 100, 2);
  if (weight < minWeight)
    return Theme.of(context).textTheme.bodyText1;
  else if (weight > maxWeight)
    return Theme.of(context).textTheme.bodyText1;
  else
    return Theme.of(context).textTheme.bodyText1!.copyWith(color: normal);
}

TextStyle? _getRedColor(BuildContext context, int index) {
  int age = context.select((BMIModel m) => m.age);
  num height = context.select((BMIModel m) => m.height);
  num weight = context.select((BMIModel m) => m.weight);
  bool gender = context.select((BMIModel m) => m.gender);
  if (age == 0 || height < 10 || weight == 0)
    return Theme.of(context).textTheme.bodyText1;
  num? maxWeight;
  if (age > 17) {
    maxWeight = (weightRank_2 - 0.1) * pow(height / 100, 2);
    num bmi = weight / pow(height / 100, 2);
    if (weight > maxWeight) {
      switch (index) {
        case 3:
          return (bmi < weightRank_3)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
        case 4:
          return (bmi < weightRank_4 && bmi >= weightRank_3)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
        case 5:
          return (bmi < weightRank_5 && bmi >= weightRank_4)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
        case 6:
          return (bmi >= weightRank_5)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
      }
    }
    return Theme.of(context).textTheme.bodyText1;
  }
  if (gender) {
    maxWeight = (maleMap[age]!.excess - 0.1) * pow(height / 100, 2);
    num bmi = weight / pow(height / 100, 2);
    if (weight > maxWeight) {
      switch (index) {
        case 1:
          return (bmi < maleMap[age]!.obesity)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
        case 2:
          return (bmi >= maleMap[age]!.obesity)
              ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
              : Theme.of(context).textTheme.bodyText1;
      }
    }
    return Theme.of(context).textTheme.bodyText1;
  }
  maxWeight = (femaleMap[age]!.excess - 0.1) * pow(height / 100, 2);
  num bmi = weight / pow(height / 100, 2);
  if (weight > maxWeight) {
    switch (index) {
      case 1:
        return (bmi < femaleMap[age]!.obesity)
            ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
            : Theme.of(context).textTheme.bodyText1;
      case 2:
        return (bmi >= femaleMap[age]!.obesity)
            ? Theme.of(context).textTheme.bodyText1!.copyWith(color: obesity)
            : Theme.of(context).textTheme.bodyText1;
    }
  }
  return Theme.of(context).textTheme.bodyText1;
}
