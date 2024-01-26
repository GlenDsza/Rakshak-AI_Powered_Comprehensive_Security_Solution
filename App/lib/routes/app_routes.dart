import 'package:flutter/material.dart';
import 'package:rakshak/presentation/citizen/add_report_screen/add_report_location_screen.dart';
import 'package:rakshak/presentation/citizen/add_report_screen/add_report_evidence_screen.dart';
import 'package:rakshak/presentation/set_role_screen/set_role_screen.dart';
import 'package:rakshak/presentation/splash_screen/splash_screen.dart';
import 'package:rakshak/presentation/change_language_screen/change_language_screen.dart';
import 'package:rakshak/presentation/citizen/sign_in_screen/sign_in_screen.dart';
import 'package:rakshak/presentation/police/sign_in_police_screen/sign_in_police_screen.dart';
import 'package:rakshak/presentation/citizen/sign_up_screen/sign_up_screen.dart';
import 'package:rakshak/presentation/citizen/home_container_screen/home_container_screen.dart';
import 'package:rakshak/presentation/police/home_container_police_screen/home_container_police_screen.dart';
import 'package:rakshak/presentation/citizen/notification_screen/notification_screen.dart';
import 'package:rakshak/presentation/police/notification_police_screen/notification_police_screen.dart';
import 'package:rakshak/presentation/citizen/add_report_screen/add_report_detail_screen.dart';
import 'package:rakshak/presentation/citizen/incident_details_screen/incident_details_screen.dart';
import 'package:rakshak/presentation/police/cctv_details_screen/cctv_details_screen.dart';
import 'package:rakshak/presentation/citizen/verify_phone_number_screen/verify_phone_number_screen.dart';
import 'package:rakshak/presentation/citizen/faqs_help_screen/faqs_help_screen.dart';
import 'package:rakshak/presentation/citizen/edit_profile_screen/edit_profile_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String setRoleScreen = '/set_role_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String signInPoliceScreen = '/sign_in_police_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String homePage = '/home_page';

  static const String changeLanguageScreen = '/change_language_screen';

  static const String dashboardPolicePage = '/dashboard_police_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String homeContainerPoliceScreen =
      '/home_container_police_screen';

  static const String notificationScreen = '/notification_screen';

  static const String notificationPoliceScreen = '/notification_police_screen';

  static const String homeListingScreen = '/home_listing_screen';

  static const String homeListingSateliteScreen =
      '/home_listing_satelite_screen';

  static const String addReportDetailScreen = '/add_report_detail_screen';

  static const String addReportLocationScreen = '/add_report_location_screen';

  static const String addReportEvidenceScreen = '/add_report_evidence_screen';

  static const String incidentDetailsScreen = '/incident_details_screen';

  static const String cctvDetailsScreen = '/cctv_details_screen';

  static const String verifyPhoneNumberScreen = '/verify_phone_number_screen';

  static const String profilePage = '/profile_page';

  static const String profilePolicePage = '/profile_police_page';

  static const String incidentsPolicePage = '/incidents_police_page';

  static const String mapPolicePage = '/maps_police_page';

  static const String faqsGetHelpScreen = '/faqs_help_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        setRoleScreen: (context) => SetRoleScreen(),
        signInScreen: SignInScreen.builder,
        signInPoliceScreen: SignInPoliceScreen.builder,
        signUpScreen: SignUpScreen.builder,
        homeContainerScreen: HomeContainerScreen.builder,
        homeContainerPoliceScreen: HomeContainerPoliceScreen.builder,
        notificationScreen: NotificationScreen.builder,
        notificationPoliceScreen: NotificationPoliceScreen.builder,
        addReportDetailScreen: AddReportDetailScreen.builder,
        addReportLocationScreen: AddReportLocationScreen.builder,
        addReportEvidenceScreen: AddReportEvidenceScreen.builder,
        incidentDetailsScreen: IncidentDetailsScreen.builder,
        cctvDetailsScreen: CctvDetailsScreen.builder,
        verifyPhoneNumberScreen: VerifyPhoneNumberScreen.builder,
        faqsGetHelpScreen: FaqsGetHelpScreen.builder,
        editProfileScreen: EditProfileScreen.builder,
        changeLanguageScreen: ChangeLanguageScreen.builder,
        initialRoute: SplashScreen.builder
        // initialRoute: AppNavigationScreen.builder,
      };
}
