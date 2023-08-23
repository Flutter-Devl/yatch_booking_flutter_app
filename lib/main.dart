
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yatch_booking_flutter_app/helper/customRoute.dart';
import 'package:yatch_booking_flutter_app/model/yatch.dart';
import 'package:yatch_booking_flutter_app/pages/checkout.dart';
import 'package:yatch_booking_flutter_app/pages/home_page_body.dart';
import 'package:yatch_booking_flutter_app/model/yatch_model.dart';
import 'package:yatch_booking_flutter_app/pages/yatch_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final YatchModel yatchModel = YatchModel();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: yatchModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSans'),
          routes: <String, WidgetBuilder>{
            '/': (_) => const MyHomePage(),
            '/detail': (_) => const Detail(),
            '/checkout': (_) => Checkout()
          },
          onGenerateRoute: (RouteSettings settings) {
            Yatch yatch;
            final List<String> pathElements = settings.name!.split('/');
            if (pathElements[0] == '') {
              return null;
            }
            if (pathElements[0] == 'detail') {
              final String planetId = pathElements[1];
              yatch = yatchModel.allYatch.firstWhere((x) {
                return x.id == planetId;
              });
              return CustomRoute<bool>(
                  builder: (BuildContext context) => Detail(yatch: yatch),
                  settings: null);
            } else if (pathElements[0] == 'checkout') {
              final String planetId = pathElements[1];
              yatch = yatchModel.allYatch.firstWhere((x) {
                return x.id == planetId;
              });
              return CustomRoute<bool>(
                  builder: (BuildContext context) => Checkout(model: yatch));
            } else
              return CustomRoute<bool>(
                  builder: (BuildContext context) => Checkout());
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget? child, YatchModel model) {
        return Scaffold(body: HomePageBody(model));
      },
    );
  }
}
