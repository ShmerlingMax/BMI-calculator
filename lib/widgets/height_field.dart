import 'package:bmi_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/generated/l10n.dart';

class HeightField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.select((BMIModel m) => m.heightUnit) == "cm"
        ? CMRow()
        : FTRow();
  }
}

class CMRow extends StatelessWidget {
  const CMRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).height,
            style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: TextField(
            controller: heightController,
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
              hintText: "cm",
              hintStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (String height) => context
                .read<BMIModel>()
                .setHeight((height == "") ? 0 : int.parse(height), "cm"),
          ),
        ),
        ChooseHeightUnit(),
      ],
    );
  }
}

class FTRow extends StatelessWidget {
  const FTRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).height,
            style: Theme.of(context).textTheme.headline1),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: Stack(
            children: [
              TextField(
                controller: heightController,
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
                  hintText: "ft",
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
                onChanged: (String height) => context
                    .read<BMIModel>()
                    .setHeight((height == "") ? 0 : int.parse(height), "ft"),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.fromLTRB(0, 15, 13, 0),
                child: Text(
                  "'",
                  style: Theme.of(context).textTheme.headline1,
                ),
              )
            ],
          ),
        ),
        Container(
          height: textFiledHeight,
          width: textFiledWeight,
          alignment: Alignment.center,
          child: Stack(
            children: [
              TextField(
                controller: heightController_1,
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
                  hintText: "in",
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                onChanged: (String height) => context
                    .read<BMIModel>()
                    .setHeight((height == "") ? 0 : int.parse(height), "inch"),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.fromLTRB(0, 15, 6, 0),
                child: Text(
                  '''"''',
                  style: Theme.of(context).textTheme.headline1,
                ),
              )
            ],
          ),
        ),
        ChooseHeightUnit(),
      ],
    );
  }
}

class ChooseHeightUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        items: [
          DropdownMenuItem(
            value: "cm",
            child: Text("cm",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20)),
          ),
          DropdownMenuItem(
            value: "ft",
            child: Text("ft",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 20)),
          ),
        ],
        value: context.select((BMIModel m) => m.heightUnit),
        onChanged: (value) {
          context.read<BMIModel>().heightUnit = value;
        },
      ),
    );
  }
}
