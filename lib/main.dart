import 'package:contacts_flutter/features/presentation/bloc/contacts/contacts_bloc.dart';
import 'package:contacts_flutter/features/presentation/pages/contacts/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BlocProvider(
    create: (context) => sl<ContactsBloc>(),
    child: MyApp(appRouter: AppRouter(),),
  ));
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> _routeObserver = RouteObserver();
  final AppRouter appRouter;

  MyApp({super.key, required this.appRouter,});

  Map<int, Color> color =
  {
    50: const Color.fromRGBO(1, 1, 1, .1),
    100: const Color.fromRGBO(1, 1, 1, .2),
    200: const Color.fromRGBO(1, 1, 1, .3),
    300: const Color.fromRGBO(1, 1, 1, .4),
    400: const Color.fromRGBO(1, 1, 1, .5),
    500: const Color.fromRGBO(1, 1, 1, .6),
    600: const Color.fromRGBO(1, 1, 1, .7),
    700: const Color.fromRGBO(1, 1, 1, .8),
    800: const Color.fromRGBO(1, 1, 1, .9),
    900: const Color.fromRGBO(1, 1, 1, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      // provide the `RouteObserver` to subtree widgets through `context`
      value: _routeObserver,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [_routeObserver],
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
            primarySwatch: MaterialColor(0xFFFFFFFF, color),
            // scaffoldBackgroundColor: Colors.white,
            dividerColor: Colors.black,
            floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue
            )

        ),
        initialRoute: HomeScreen.id,
        onGenerateRoute: appRouter.onGenerateRoutes,
        // home: BlocProvider(
        //   create: (context) => sl<ContactsBloc>(),
        //   child: Scaffold(
        //     appBar: AppBar(title: Text('Contact List'),),
        //     body: ContactsScreen(),
        //   ),
        // ),
      ),
    );
  }
}

