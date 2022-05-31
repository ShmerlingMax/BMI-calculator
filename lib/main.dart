import 'package:bmi_calculator/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:bmi_calculator/screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'generated/l10n.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (_) => BMIModel(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragStart: (DragStartDetails details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        onHorizontalDragStart: (DragStartDetails details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          onGenerateTitle: (BuildContext context) => S.of(context).app_name,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            if (locale == null) {
              return supportedLocales.first;
            }
            for (final Locale supportedLocale in supportedLocales) {
              if (locale.languageCode == supportedLocale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: MainScreen(),
        ),
      ),
    );
  }
}
