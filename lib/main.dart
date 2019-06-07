import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/widgets/drawer/drawer_md2.dart';
import 'package:provider/provider.dart';

import 'providers/bloc.dart';
import 'providers/navigation_provider.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(
    MyApp(),
  );
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(
          notifier: ThemeProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>.value(
          notifier: NavigationProvider(),
        ),
        ChangeNotifierProvider<Bloc>.value(
          notifier: Bloc(),
        ),
      ],
      child: MaterialAppWidget(),
    );
  }
}

class MaterialAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Provider.of<ThemeProvider>(context).brightnessTheme;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: brightness,
        primaryColor: Colors.blueAccent,
        fontFamily: 'ProductSans',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget currentWidget =
        Provider.of<NavigationProvider>(context).currentWidget;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1256)
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.brightness_7,
                  ),
                  onPressed: () {
                    if (themeProvider.brightnessTheme == Brightness.light) {
                      themeProvider.setBrightness(Brightness.dark);
                    } else {
                      themeProvider.setBrightness(Brightness.light);
                    }
                  },
                )
              ],
            ),
            drawer: DrawlerMaterialDesign2(),
            body: currentWidget,
          );
        else
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.brightness_7,
                  ),
                  onPressed: () {
                    if (themeProvider.brightnessTheme == Brightness.light) {
                      themeProvider.setBrightness(Brightness.light);
                    } else {
                      themeProvider.setBrightness(Brightness.dark);
                    }
                  },
                )
              ],
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 256,
                  child: DrawlerMaterialDesign2(),
                ),
                Expanded(
                  child: currentWidget,
                ),
              ],
            ),
          );
      },
    );
  }
}
