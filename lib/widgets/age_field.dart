import 'package:bmi_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class AgeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).age, style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: ageController,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).textTheme.headline2!.color!),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Theme.of(context).cardColor),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String age) =>
                context.read<BMIModel>().age = age == "" ? 0 : int.parse(age),
          ),
        )
      ],
    );
  }
}
