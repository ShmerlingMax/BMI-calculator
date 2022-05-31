import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bmi_calculator/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bmi_calculator/theme.dart';

class MyAppBar {
  getAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).app_bar_title),
      actions: [
        IconButton(
            onPressed: () => _showInfoWindow(context),
            icon: Icon(Icons.info_outline)),
        PopupMenuButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(S.of(context).share_app,
                  style: Theme.of(context).textTheme.headline3),
              value: 1,
            ),
            PopupMenuItem(
              child: Text(S.of(context).rate_app,
                  style: Theme.of(context).textTheme.headline3),
              value: 2,
            ),
            PopupMenuItem(
              child: Text(S.of(context).more_app,
                  style: Theme.of(context).textTheme.headline3),
              value: 3,
            ),
            PopupMenuItem(
              child: Text(S.of(context).help_support,
                  style: Theme.of(context).textTheme.headline3),
              value: 4,
            )
          ],
          onSelected: (int index) {
            switch (index) {
              case 1:
                onShare(context);
                break;
              case 2:
                launchInBrowser(context, appURL);
                break;
              case 3:
                launchInBrowser(context, devURL);
                break;
              case 4:
                sendEmail(context, devEmail, titleEmail, "");
                break;
            }
          },
        ),
      ],
    );
  }
}

_showInfoWindow(BuildContext context) => showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          S.of(context).info_window_title,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            S.of(context).info_window_context,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).close,
              style: TextStyle(color: Color(0xFF0040FF)),
            ),
          ),
        ],
      ),
    );

void onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(appURL,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}

Future<void> launchInBrowser(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).open_url),
          content: Text(S.of(context).no_url),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

Future<void> sendEmail(
    BuildContext context, String toMailId, String subject, String body) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).open_mail),
          content: Text(S.of(context).no_mail),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
