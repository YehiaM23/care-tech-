import 'package:flutter/material.dart';
import 'core/Routing/app_router.dart';
import 'features/home/onboarding/onboarding_screen.dart';
import 'ui.dart';

class DocApp extends StatelessWidget {
  final AppRouter appRouter;
  const DocApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Care Connect',
    debugShowCheckedModeBanner: false,
    theme: appTheme(Colors.blue),
    onGenerateRoute: appRouter.generateRoute,
    home: const OnBoardingScreen(),
  );
}
