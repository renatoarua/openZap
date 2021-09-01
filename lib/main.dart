import 'package:flutter/material.dart';
import 'package:openzap/store/app.store.dart';
import 'package:openzap/view/home.view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppStore>.value(
          value: AppStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Open Zap!',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomeView(),
      ),
    );
  }
}
