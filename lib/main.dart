import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/blocs/home/home_bloc.dart';
import 'package:news_app/logic/cubits/main_screen_tab.dart';
import 'package:news_app/logic/cubits/theme.dart';
import 'package:news_app/routes.dart';
import 'package:news_app/presentation/screens/home.dart';
import 'package:news_app/presentation/screens/search.dart';
import 'package:news_app/presentation/screens/settings.dart';
import 'package:news_app/data/providers/hive_storage.dart';
import 'package:news_app/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveStorageService.init();
  final ThemeMode initialThemeMode = HiveStorageService().getThemeMode();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => MainScreenTabCubit()),
      BlocProvider(
          create: (context) => ThemeCubit()..setThemeMode(initialThemeMode)),
      BlocProvider(create: (context) => HomeBloc()..add(FetchNews(index: 0))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(context, currentTheme: context.watch<ThemeCubit>().state),
      // theme: AppTheme.getTheme(context, currentTheme: ThemeMode.light),
      // darkTheme: AppTheme.getTheme(context, currentTheme: ThemeMode.dark),
      // initialRoute: '/home',
      // onGenerateRoute: _generateRoute,
      home: const MainScreen(),
    );
  }

  // Route _generateRoute(RouteSettings settings) {
  //   Widget screen;

  //   switch (settings.name) {
  //     case '/home':
  //       screen = const HomeScreen();
  //       break;
  //     default:
  //       screen = const HomeScreen();
  //   }

  //   return MaterialPageRoute(builder: (context) => screen);
  // }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainScreenTabCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: routes.map((route) {
              return Navigator(
                onGenerateInitialRoutes: (navigator, initialRoute) {
                  return [
                    MaterialPageRoute(builder: (context) => getPage(route))
                  ];
                },
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<MainScreenTabCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            currentIndex: state,
            onTap: (int index) =>
                BlocProvider.of<MainScreenTabCubit>(context).setTab(index),
          );
        },
      ),
    );
  }

  Widget getPage(String route) {
    switch (route) {
      case Routes.home:
        return HomeScreen();
      case Routes.search:
        return SearchScreen();
      case Routes.settings:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }
}
