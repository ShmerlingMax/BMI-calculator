import 'package:bmi_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class WeightField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.select((BMIModel m) => m.weightUnit) == "kg") {
      return KGRow();
    } else {
      return (context.select((BMIModel m) => m.weightUnit) == "lb")
          ? LBRow()
          : STRow();
    }
  }
}

class KGRow extends StatelessWidget {
  const KGRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).weight,
            style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: weightController,
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
              hintText: "kg",
              hintStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String weight) => context
                .read<BMIModel>()
                .setWeight((weight == "") ? 0 : int.parse(weight), "kg"),
          ),
        ),
        ChooseWeightUnit(),
      ],
    );
  }
}

class LBRow extends StatelessWidget {
  const LBRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).weight,
            style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: weightController,
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
              hintText: "lb",
              hintStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String weight) => context
                .read<BMIModel>()
                .setWeight((weight == "") ? 0 : int.parse(weight), "lb"),
          ),
        ),
        ChooseWeightUnit(),
      ],
    );
  }
}

class STRow extends StatelessWidget {
  const STRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).weight,
            style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: weightController,
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
              hintText: "st",
              hintStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String weight) => context
                .read<BMIModel>()
                .setWeight((weight == "") ? 0 : int.parse(weight), "st"),
          ),
        ),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: weightController_1,
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
              hintText: "lb",
              hintStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String weight) => context
                .read<BMIModel>()
                .setWeight((weight == "") ? 0 : int.parse(weight), "lb"),
          ),
        ),
        ChooseWeightUnit(),
      ],
    );
  }
}

class ChooseWeightUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        items: [
          DropdownMenuItem(
            value: "kg",
            child: Text("kg",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20)),
          ),
          DropdownMenuItem(
            value: "lb",
            child: Text("lb",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20)),
          ),
          DropdownMenuItem(
            value: "st",
            child: Text("st",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20)),
          ),
        ],
        value: context.select((BMIModel m) => m.weightUnit),
        onChanged: (value) {
          context.read<BMIModel>().weightUnit = value;
        },
      ),
    );
  }
}
