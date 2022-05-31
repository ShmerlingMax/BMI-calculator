import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        textTheme:
            TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 20)),
        iconTheme: IconThemeData(color: Colors.white)),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, selectionHandleColor: Colors.black),
    textTheme: TextTheme(
      //Возраст:, Рост:, Вес:
      headline1: GoogleFonts.montserrat(
          fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
      //Значения, которые вводят
      headline2: GoogleFonts.montserrat(fontSize: 25, color: Colors.black),
      //Текст в dropDownButton
      headline3: GoogleFonts.montserrat(fontSize: 20, color: Colors.black),
      //Текс информационного окна
      headline4: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
      //Индекс ИМТ
      headline5: GoogleFonts.montserrat(
          fontSize: 35, color: Colors.black, fontWeight: FontWeight.w300),
      //Подписи к ИМТ и диапазону
      headline6: GoogleFonts.montserrat(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      //Текст таблицы
      bodyText1: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
      //Текст заключения
      bodyText2: GoogleFonts.montserrat(fontSize: 15, color: Colors.black),
      //hint
      subtitle1: GoogleFonts.montserrat(color: Color(0xFFC9C9C9), fontSize: 23),
    ),
    buttonTheme: ButtonThemeData(alignedDropdown: true),
    iconTheme: IconThemeData(color: Colors.black, size: 50),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5))),
    cardColor: Colors.blue);

final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
        color: Color(0xFF232222),
        textTheme:
            TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 20)),
        iconTheme: IconThemeData(color: Colors.white)),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white, selectionHandleColor: Colors.black),
    textTheme: TextTheme(
      //Возраст:, Рост:, Вес:
      headline1: GoogleFonts.montserrat(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      //Значения, которые вводят
      headline2: GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
      //Текст в dropDownButton
      headline3: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
      //Текс информационного окна
      headline4: GoogleFonts.montserrat(fontSize: 15, color: Colors.white),
      //Индекс ИМТ
      headline5: GoogleFonts.montserrat(
          fontSize: 35, color: Colors.white, fontWeight: FontWeight.w300),
      //Подписи к ИМТ и диапазону
      headline6: GoogleFonts.montserrat(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      //Текст таблицы
      bodyText1: GoogleFonts.montserrat(fontSize: 15, color: Colors.white),
      //Текст заключения
      bodyText2: GoogleFonts.montserrat(fontSize: 15, color: Colors.white),
      //hint
      subtitle1: GoogleFonts.montserrat(color: Color(0xFF878787), fontSize: 23),
    ),
    buttonTheme: ButtonThemeData(alignedDropdown: true),
    iconTheme: IconThemeData(color: Colors.white, size: 50),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 5))),
    cardColor: Colors.purple);

// Цвета
final maleColor = Colors.blue;
final femaleColor = Colors.pink;
final lack = Colors.yellow;
final normal = Colors.green;
final obesity = Color(0xFFF80B00);

// Числа
final double? textFiledHeight = 80;
final double? textFiledWeight = 80;

// контроллеры
final ageController = TextEditingController();
final heightController = TextEditingController();
final weightController = TextEditingController();
final heightController_1 = TextEditingController();
final weightController_1 = TextEditingController();

//Ссылки
final appURL =
    "https://play.google.com/store/apps/details?id=com.shmerling.bmi_calculator";
final devURL = "https://play.google.com/store/apps/dev?id=6668873248654509380";
final devEmail = "shmerling.max@gmail.com";
final titleEmail = "BMI Calculator";

//ИМТ для людей старше 17 лет
num weightRank_1 = 18.5;
num weightRank_2 = 25.0;
num weightRank_3 = 30.0;
num weightRank_4 = 35.0;
num weightRank_5 = 40.0;

class WeightRank {
  WeightRank(this.lack, this.excess, this.obesity);

  num lack = 0;
  num excess = 0;
  num obesity = 0;
}

//таблица ИМТ для пареней
final maleMap = {
  1: WeightRank(13.9, 17.5, 19.0),
  2: WeightRank(13.8, 17.4, 18.9),
  3: WeightRank(13.4, 17.0, 18.4),
  4: WeightRank(13.1, 16.8, 18.2),
  5: WeightRank(12.9, 16.7, 18.3),
  6: WeightRank(13.0, 16.9, 18.5),
  7: WeightRank(13.1, 17.1, 19.0),
  8: WeightRank(13.3, 17.5, 19.7),
  9: WeightRank(13.5, 18.0, 20.5),
  10: WeightRank(13.7, 18.6, 21.4),
  11: WeightRank(14.1, 19.3, 22.5),
  12: WeightRank(14.5, 20.0, 23.6),
  13: WeightRank(14.9, 20.9, 24.8),
  14: WeightRank(15.5, 21.9, 25.9),
  15: WeightRank(16.0, 22.8, 27.0),
  16: WeightRank(16.5, 23.6, 27.9),
  17: WeightRank(16.9, 24.4, 28.6)
};

final femaleMap = {
  1: WeightRank(13.4, 17.2, 18.8),
  2: WeightRank(13.3, 17.1, 18.7),
  3: WeightRank(13.1, 16.9, 18.4),
  4: WeightRank(12.8, 16.9, 18.5),
  5: WeightRank(12.7, 17.0, 18.8),
  6: WeightRank(12.7, 17.1, 19.2),
  7: WeightRank(12.7, 17.4, 19.8),
  8: WeightRank(12.9, 17.8, 20.6),
  9: WeightRank(13.1, 18.4, 21.5),
  10: WeightRank(13.5, 19.1, 22.6),
  11: WeightRank(13.9, 20.0, 23.7),
  12: WeightRank(14.4, 20.9, 25.0),
  13: WeightRank(14.9, 21.9, 26.2),
  14: WeightRank(15.4, 22.8, 27.3),
  15: WeightRank(15.9, 23.6, 28.2),
  16: WeightRank(16.2, 24.2, 28.9),
  17: WeightRank(16.4, 24.6, 29.3)
};
