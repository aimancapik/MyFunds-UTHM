import 'package:get/get.dart';
import 'package:myfundsuthm/ui/screens/auth/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/routes.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthenticationRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => GetMaterialApp(
        title: 'MyFunds UTHM',
        theme: AppTheme(context).initTheme(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: Get.find<AuthenticationRepository>().isUserLoggedIn()
            ? RouteGenerator.main // Redirect to home screen
            : RouteGenerator.welcomeScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
