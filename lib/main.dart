import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/core/config/app_themes.dart';
import 'package:posmobile/data/repository/auth_repository.dart';
import 'package:posmobile/dependecies_injection/dependencies_injection.dart';
import 'package:posmobile/presentations/dashboard/main_page.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/login/ui/login_screen.dart';

void main() {
  dependenciesInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(locator<AuthRepository>())),
      ],
      child: MaterialApp(
        title: 'POS',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.system,

        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
