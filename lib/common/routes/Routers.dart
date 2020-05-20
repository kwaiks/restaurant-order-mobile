import 'package:flutter/material.dart';
import 'package:mesan_mobile/booking/screens/menu/MenuScreen.dart';
import 'package:mesan_mobile/booking/screens/search/SearchAllScreen.dart';
import 'package:mesan_mobile/booking/screens/search/SearchByCategoryScreen.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'Transitions.dart';

///Imports all screens
//Authentication Module
import '../../authentication/screens/AuthenticationScreen.dart';
import '../../authentication/screens/LoginScreen.dart';
import '../../authentication/screens/RegisterScreen.dart';
import '../../authentication/screens/VerifyOTPScreen.dart';

//Main Module
import '../../main/screens/MainScreen.dart';
import '../../main/screens/HomeFragment.dart';
import '../../main/screens/AccountFragment.dart';
import '../../main/screens/HistoryFragment.dart';
import '../../main/screens/InboxFragment.dart';

////Declare Screen Route Name Variables
//Authentication Module
const String authenticationRoute = '/authRoute';
const String loginRoute = '/login';
const String registerRoute = '/register';
const String verifyRoute = '/verify';

//Main Module
const String mainRoute = '/main';

//Booking Module
const String searchByNameRoute = '/searchAll';
const String searchByCategoryRoute = '/searchCategory';
const String bookingMenuList = '/bookingMenuList';

////Declare Screen without any arguments
//Authentication Module
final Widget authPage = AuthenticationScreen();
final Widget loginPage = LoginScreen();
final Widget registerPage = RegisterScreen();

//Main Module
final Widget mainPage = MainScreen();
final Widget homeFragment = HomeFragment();
final Widget inboxFragment = InboxFragment();
final Widget historyFragment = HistoryFragment();
final Widget acccountFragment = AccountFragment();

//Booking Module
final Widget searchAllPage = SearchAllScreen();

//Router Class
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final ScreenArguments args = settings.arguments;
    switch(settings.name){
      case authenticationRoute:
        return MaterialPageRoute(builder: (_)=> authPage);
      case mainRoute:
        return SlideRoute(page: mainPage);
      case loginRoute:
        return SlideRoute(page: loginPage);
      case registerRoute:
        return SlideRoute(page: registerPage);
      case verifyRoute:
        return SlideRoute(page: VerifyOTP(phoneNumber: args.phoneNumber) ,direction: 'right');
      case searchByNameRoute:
        return SlideRoute(page: searchAllPage);
      case searchByCategoryRoute:
        return SlideRoute(page: SearchCategoryScreen(category: args.category));
      case bookingMenuList:
        return SlideRoute(page: BookingMenuListScreen(resto: args.restaurant,));
      default:
        return Fade(page:mainPage);
    }
  }
}


//Class to receive all passed arguments
class ScreenArguments {
  final String category;
  final String phoneNumber;
  final Restaurant restaurant;

  ScreenArguments({
    this.category,
    this.phoneNumber,
    this.restaurant
  });
}
