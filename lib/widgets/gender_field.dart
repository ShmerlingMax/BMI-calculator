import 'dart:math';
import 'package:bmi_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';

class GenderField extends StatefulWidget {
  GenderField({
    Key? key,
  }) : super(key: key);

  @override
  _GenderFieldState createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
      child: Center(
        child: Container(
          child: _buildFlipAnimation(),
        ),
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
      context.read<BMIModel>().gender = _showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide
            ? Container(
                key: ValueKey(true),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(color: maleColor, width: 3),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: IconButton(
                  disabledColor: Theme.of(context).iconTheme.color!,
                  icon: Icon(Icons.male, color: maleColor),
                  onPressed: null,
                  iconSize: Theme.of(context).iconTheme.size!,
                ),
              )
            : Container(
                key: ValueKey(false),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(color: femaleColor, width: 3),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: IconButton(
                  disabledColor: Theme.of(context).iconTheme.color!,
                  icon: Icon(
                    Icons.female,
                    color: femaleColor,
                  ),
                  onPressed: null,
                  iconSize: Theme.of(context).iconTheme.size!,
                ),
              ),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
