import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/theme.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class Conclusion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).conclusion, style: Theme.of(context).textTheme.headline6),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: _GetTextConclusion(),
          )
        ],
      ),
    );
  }
}


class _GetTextConclusion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int age = context.select((BMIModel m) => m.age);
    num height = context.select((BMIModel m) => m.height);
    num weight = context.select((BMIModel m) => m.weight);
    bool gender = context.select((BMIModel m) => m.gender);
    if (age == 0 || height < 10 || weight == 0)
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text("-----", style: Theme.of(context).textTheme.headline5),
      );
    num? minWeight;
    num? maxWeight;
    if (age > 17) {
      minWeight = weightRank_1 * pow(height / 100, 2);
      maxWeight = (weightRank_2 - 0.1) * pow(height / 100, 2);
      if (weight < minWeight)
        return Text(S.of(context).conclusion_lack,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
      else if (weight > maxWeight)
        return Text(S.of(context).conclusion_obesity,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
      else
        return Text(S.of(context).conclusion_normal,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
    }
    if (gender) {
      minWeight = maleMap[age]!.lack * pow(height / 100, 2);
      maxWeight = (maleMap[age]!.excess - 0.1) * pow(height / 100, 2);
      if (weight < minWeight)
        return Text(S.of(context).conclusion_lack,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
      else if (weight > maxWeight)
        return Text(S.of(context).conclusion_obesity,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
      else
        return Text(S.of(context).conclusion_normal,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 7,
            overflow: TextOverflow.ellipsis);
    }
    minWeight = femaleMap[age]!.lack * pow(height / 100, 2);
    maxWeight = (femaleMap[age]!.excess - 0.1) * pow(height / 100, 2);
    if (weight < minWeight)
      return Text(S.of(context).conclusion_lack,
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: 7,
          overflow: TextOverflow.ellipsis);
    else if (weight > maxWeight)
      return Text(S.of(context).conclusion_obesity,
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: 7,
          overflow: TextOverflow.ellipsis);
    else
      return Text(S.of(context).conclusion_normal,
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: 7,
          overflow: TextOverflow.ellipsis);
  }
}
