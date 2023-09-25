import '../themes/theme.dart';
import 'package:flutter/material.dart';
import '../routes/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: createLightTheme(),
      themeMode: ThemeMode.light,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
