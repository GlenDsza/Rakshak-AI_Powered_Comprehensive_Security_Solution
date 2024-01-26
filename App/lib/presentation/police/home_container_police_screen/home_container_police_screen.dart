import 'bloc/home_container_police_bloc.dart';
import 'models/home_container_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/presentation/police/dashboard_police_page/dashboard_police_page.dart';
import 'package:rakshak/presentation/police/incidents_police_page/incidents_police_page.dart';
import 'package:rakshak/presentation/police/profile_police_page/profile_police_page.dart';
import 'package:rakshak/presentation/police/map_police_page/map_police_page.dart';
import 'package:rakshak/widgets/custom_police_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeContainerPoliceScreen extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<HomeContainerPoliceBloc>(
        create: (context) => HomeContainerPoliceBloc(HomeContainerPoliceState(
            homeContainerPoliceModelObj: HomeContainerPoliceModel(),
            id: arg[NavigationArgs.id],
            fullname: arg[NavigationArgs.fullname],
            station: arg[NavigationArgs.station]))
          ..add(HomeContainerPoliceInitialEvent()),
        child: HomeContainerPoliceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeContainerPoliceBloc, HomeContainerPoliceState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstant.gray50,
              body: Navigator(
                  key: navigatorKey,
                  initialRoute: AppRoutes.dashboardPolicePage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                      pageBuilder: (ctx, ani, ani1) =>
                          getCurrentPage(context, routeSetting.name!),
                      transitionDuration: Duration(seconds: 0))),
              bottomNavigationBar:
                  CustomPoliceBottomBar(onChanged: (BottomBarEnum type) {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, getCurrentRoute(type));
              })));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard:
        return AppRoutes.dashboardPolicePage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePolicePage;
      case BottomBarEnum.Incidents:
        return AppRoutes.incidentsPolicePage;
      case BottomBarEnum.Map:
        return AppRoutes.mapPolicePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.dashboardPolicePage:
        return DashboardPolicePage.builder(context);
      case AppRoutes.profilePolicePage:
        return ProfilePolicePage.builder(context);
      case AppRoutes.incidentsPolicePage:
        return IncidentsPolicePage.builder(context);
      case AppRoutes.mapPolicePage:
        return MapPolicePage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
