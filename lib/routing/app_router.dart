import 'package:blogapp/pages/add_blog_page.dart';
import 'package:blogapp/pages/editable_page.dart';
import 'package:blogapp/pages/error_page.dart';
import 'package:blogapp/pages/home_page.dart';
import 'package:blogapp/pages/login_page.dart';
import 'package:blogapp/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blogapp/routing/app_route_constants.dart';
import 'package:blogapp/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyAppRouter{

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    redirect: (context, state) async {
      debugPrint("Path  :${state.uri}");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getBool('isLoggedIn')==true){
        if(state.uri.toString().contains('/login')){
          return '/home';
        }
      }
      // else if(state.uri.toString().contains('/loginwithphone')){
      //   return '/loginwithphone';
      // }
      else{
        return '/login';
      }
      return null;
    },
    debugLogDiagnostics: true,
    errorPageBuilder: (context,state){
      return const MaterialPage(child: ErrorPage());
    },
    routes: [
      // Splash Screen Route :
      GoRoute(
        name: MyAppRouteConstants.splashScreenRouteName,
        path: '/',
        pageBuilder: (context,state){
          debugPrint('config page : SplashScreen');
          return const MaterialPage(child: SplashScreen()); },
      ),
      // Login Page Route :
      GoRoute(
        name: MyAppRouteConstants.loginRouteName,
        path: '/login',
        pageBuilder: (context,state){
          debugPrint('config page : LoginPage');
          return const MaterialPage(child: LoginPage()); },
      ),
      // SignUp Page Route :
      GoRoute(
        name: MyAppRouteConstants.signUpRouteName,
        path: '/signup',
        pageBuilder: (context,state){
          debugPrint('config page : SignUpPage');
          return const MaterialPage(child: SignUpPage()); },
      ),
      // Home Page Route :
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: '/home',
        pageBuilder: (context,state){
          debugPrint('config page : HomePage');
          return const MaterialPage(child: HomePage()); },
      ),
      GoRoute(
        name: MyAppRouteConstants.addBlogRouteName,
        path: '/addblog',
        // builder: (context,state){ return Home();},
        pageBuilder: (context,state){
          debugPrint('config page : AddBlogPage');
          return const MaterialPage(child: AddBlogPage(),); },
      ),
      GoRoute(
        name: MyAppRouteConstants.editBlogRouteName,
        path: '/edit/:id',
        // builder: (context,state){ return Home();},
        pageBuilder: (context,state){
          debugPrint('config page : EditBlogPage');
          final id = state.pathParameters['id']??"0";
          return MaterialPage(child: EditBlogPage(id),
          );
        },
      ),
    ],
  );

  GoRouter getRouter(BuildContext context){
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) async {
        debugPrint("Path In here  :${state.path}");

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        if(sharedPreferences.getBool('isLoggedIn')==true){
          debugPrint("Path  :${state.path}");
        }else{
          return null;
        }
        return null;
      },
      debugLogDiagnostics: true,
      errorPageBuilder: (context,state){
        return const MaterialPage(child: ErrorPage());
      },
      routes: [
        // Splash Screen Route :
        GoRoute(
          name: MyAppRouteConstants.splashScreenRouteName,
          path: '/',
          // builder: (context,state){ return Home();},
          pageBuilder: (context,state){
            debugPrint('config page : SplashScreen');
            return const MaterialPage(child: SplashScreen()); },
        ),
        // Login Page Route :
        GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: '/login',
          // builder: (context,state){ return Home();},
          pageBuilder: (context,state){
            debugPrint('config page : LoginPage');
            return const MaterialPage(child: LoginPage()); },
        ),
        // SignUp Page Route :
        GoRoute(
          name: MyAppRouteConstants.signUpRouteName,
          path: '/signup',
          // builder: (context,state){ return Home();},
          pageBuilder: (context,state){
            debugPrint('config page : SignUpPage');
            return const MaterialPage(child: SignUpPage()); },
        ),
        // Home Page Route :
        GoRoute(
          name: MyAppRouteConstants.homeRouteName,
          path: '/home',
          // builder: (context,state){ return Home();},
          pageBuilder: (context,state){
            debugPrint('config page : HomePage');
            return const MaterialPage(child: HomePage()); },
        ),
        GoRoute(
          name: MyAppRouteConstants.addBlogRouteName,
          path: '/addblog',
          // builder: (context,state){ return Home();},
          pageBuilder: (context,state){
            debugPrint('config page : AddBlogPage');
            return const MaterialPage(child: AddBlogPage(),); },
        ),
      ],
    );
  }
}