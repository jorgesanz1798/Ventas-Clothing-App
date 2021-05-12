import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/view/theme_manager.dart';
import 'view/shared/navigation_app_bar.dart';

void main() async {
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
        home: NavigationAppBar(),
      ),
    );
  }
}
