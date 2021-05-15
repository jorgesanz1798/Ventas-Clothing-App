import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/view/theme_manager.dart';
import 'view/shared/navigation_app_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //onGenerateRoute: Router.generateRoute,
        //initialRoute: productsOverviewRoute,
        title: ThemeManager.appName,
        theme: ThemeManager.lightTheme,
        home: FutureBuilder(
          // Replace the 3 second delay with your initialization code:
          future: Future.delayed(Duration(seconds: 3)),
          builder: (context, AsyncSnapshot snapshot) {
            // Show splash screen while waiting for app resources to load:
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Image.asset(
                  "assets/images/logo-app.jpg",
                  fit: BoxFit.fitHeight,
                ))),
                debugShowCheckedModeBanner: false,
              );
            } else {
              // Loading is done, return the app:
              return MaterialApp(
                home: NavigationAppBar(),
                debugShowCheckedModeBanner: false,
              );
            }
          },
        ),
      ),
    );
  }
}
