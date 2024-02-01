import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

//==========================================================================================================================================================

// Main function to start the app
void main() async {
  // Ensure that everything is initialized before opening the app
  WidgetsFlutterBinding.ensureInitialized();

  // Set up Bloc observer for logging Bloc events
  Bloc.observer = MyBlocObserver();

  // Initialize Dio for network requests
  DioHelper.init();

  // Initialize CacheHelper for local storage
  await CacheHelpher.init();

  // Check if the app is in dark mode from local storage
  bool? isDark = CacheHelpher.getData(key: 'isDark');

  // Run the app with the retrieved dark mode value
  runApp(MyApp(isDark ?? false));
}

//==========================================================================================================================================================
// MyApp widget, the root of the application
class MyApp extends StatelessWidget {
  final bool isDark;

  // Constructor for MyApp
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide NewsCubit with required dependencies and initial data
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getsports()
            ..getScience(),
        ),
        // Provide DarkCubit with initial dark mode value
        BlocProvider(
          create: (context) => DarkCubit()..changeAppMode(isShared: isDark),
        )
      ],
      child: BlocConsumer<DarkCubit, DarkStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // Define app theme and dark theme
          theme: ThemeData(
            // Light theme colors and styles
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              titleSpacing: 20.0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 20.0,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            // Dark theme colors and styles
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          // Set app theme mode based on dark mode state
          themeMode:
              DarkCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: const HomeLayout(), // Start with HomeLayout widget
        ),
      ),
    );
  }
}
