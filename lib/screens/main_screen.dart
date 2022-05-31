import 'package:bmi_calculator/widgets/weight_field.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets/app_bar.dart';
import 'package:bmi_calculator/widgets/age_field.dart';
import 'package:bmi_calculator/widgets/height_field.dart';
import 'package:bmi_calculator/widgets/bmi_result.dart';
import 'package:bmi_calculator/widgets/gender_field.dart';
import 'package:bmi_calculator/widgets/bmi_table.dart';
import 'package:bmi_calculator/widgets/bmi_conclusion.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/theme.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar().getAppBar(context),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            height: 750,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AgeField(),
                    GenderField(),
                  ],
                ),
                HeightField(),
                WeightField(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(Theme.of(context)
                            .inputDecorationTheme
                            .border!
                            .borderSide
                            .copyWith(
                                color: _calculateColor(
                                    context.select((BMIModel m) => m.gender),
                                    context.select((BMIModel m) => m.age),
                                    context.select((BMIModel m) => m.height),
                                    context.select((BMIModel m) => m.weight)))),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<BMIModel>().clear();
                                  },
                                  icon: Icon(Icons.refresh)),
                              IconButton(
                                  onPressed: (context.select(
                                                  (BMIModel m) => m.height) ==
                                              0 ||
                                          context.select(
                                                  (BMIModel m) => m.weight) ==
                                              0)
                                      ? null
                                      : () {
                                          num index = Provider.of<BMIModel>(
                                                      context,
                                                      listen: false)
                                                  .weight /
                                              pow(
                                                  Provider.of<BMIModel>(context,
                                                              listen: false)
                                                          .height /
                                                      100,
                                                  2);
                                          onShare(context, index);
                                        },
                                  icon: Icon(Icons.share))
                            ],
                          ),
                        ),
                        Result(),
                        BMITable(),
                        Conclusion(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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

void onShare(BuildContext context, num index) async {
  final box = context.findRenderObject() as RenderBox?;
  String text = (index > 100) ? ">100" : (index).toStringAsFixed(1);
  await Share.share(
      "${S.of(context).share_1} $text. ${S.of(context).share_2}: $appURL",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
