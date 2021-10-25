import 'package:breakingbad/appRouter.dart';
import 'package:breakingbad/shared/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  MyApp(this.appRouter);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
