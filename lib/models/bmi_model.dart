import 'package:flutter/material.dart';
import 'package:bmi_calculator/theme.dart';

class Height {
  num cm = 0;
  num ft = 0;
  num inch = 0;

  clear() {
    cm = 0;
    ft = 0;
    inch = 0;
  }

  get heightCM => cm + ft * 30.48 + inch * 2.54;
}

class Weight {
  num kg = 0;
  num lb = 0;
  num st = 0;

  clear() {
    kg = 0;
    lb = 0;
    st = 0;
  }

  get weightKG => kg + lb * 0.45359293319936 + st * 6.35029318;
}

class BMIModel with ChangeNotifier {
  int _age = 0;
  Height _height = Height();
  Weight _weight = Weight();

  //true - парень
  bool _gender = true;

  // cm, ft
  String? _heightUnit = "cm";

  // kg lb st
  String? _weightUnit = "kg";

  int get age => _age;

  num get height => _height.heightCM;

  num get weight => _weight.weightKG;

  String? get heightUnit => _heightUnit;

  String? get weightUnit => _weightUnit;

  bool get gender => _gender;

  set age(int age) {
    _age = age;
    notifyListeners();
  }

  setHeight(num height, String flag) {
    if (flag == "cm") {
      _height.cm = height;
    } else if (flag == "ft") {
      _height.ft = height;
    } else {
      _height.inch = height;
    }
    notifyListeners();
  }

  setWeight(num weight, String flag) {
    if (flag == "kg") {
      _weight.kg = weight;
    } else if (flag == "lb") {
      _weight.lb = weight;
    } else {
      _weight.st = weight;
    }
    notifyListeners();
  }

  set heightUnit(String? heightUnit) {
    if (_heightUnit == heightUnit) return;
    _heightUnit = heightUnit;
    _height.clear();
    heightController.clear();
    heightController_1.clear();
    notifyListeners();
  }

  set weightUnit(String? weightUnit) {
    if (_weightUnit == weightUnit) return;
    _weightUnit = weightUnit;
    _weight.clear();
    weightController.clear();
    weightController_1.clear();
    notifyListeners();
  }

  set gender(bool gender) {
    _gender = gender;
    notifyListeners();
  }

  clear() {
    ageController.clear();
    heightController.clear();
    weightController.clear();
    heightController_1.clear();
    weightController_1.clear();
    _weight.clear();
    _height.clear();
    age = 0;
    notifyListeners();
  }
}
