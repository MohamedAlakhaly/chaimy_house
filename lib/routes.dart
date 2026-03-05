import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/modules/auth/choose_auth_method/view/choose_auth_method_view.dart';
import 'package:chimay_house/modules/auth/forget_password/view/forget_password_view.dart';
import 'package:chimay_house/modules/auth/sign_in/view/sign_in_view.dart';
import 'package:chimay_house/modules/auth/sign_up/view/sign_up_view.dart';
import 'package:chimay_house/modules/auth/success_send_email/view/success_send_email_view.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/view/choose_language_view.dart';
import 'package:chimay_house/modules/auth/verify_email/view/verify_email_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/education/home/view/education_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/education/modules/register_for_education/view/register_for_education_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/change_password/view/change_password_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/edit_profile/view/edit_profile_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/help_chat/view/help_chat_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/faq/view/faq_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/rate_us/view/rate_us_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/share_app/view/share_app_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/manage_language/view/manage_language_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/modules/change_theme/view/change_theme_view.dart';
// import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/settings/view/settings_view.dart';
import 'package:chimay_house/modules/navigation_menu/view/navigation_menu.dart';
import 'package:chimay_house/modules/auth/on_boarding/view/on_boarding_view.dart';
import 'package:chimay_house/modules/auth/splash/view/splash_view.dart';

List<GetPage<dynamic>>? getPages = [
  //! auth
  GetPage(name: AppRoutes.splash, page: () => const SplashView()),
  GetPage(
      name: AppRoutes.chooseLanguage, page: () => const ChooseLanguageView()),
  GetPage(name: AppRoutes.onBoarding, page: () => const OnBoardingView()),
  GetPage(
      name: AppRoutes.chooseAuthMethod,
      page: () => const ChooseAuthMethodView()),
  GetPage(name: AppRoutes.signIn, page: () => const SignInView()),
  GetPage(
      name: AppRoutes.forgetPassword, page: () => const ForgetPasswordView()),
  GetPage(
      name: AppRoutes.successSendEmail,
      page: () => const SuccessSendEmailView()),
  GetPage(name: AppRoutes.signUp, page: () => const SignUpView()),
  GetPage(name: AppRoutes.verifyEmail, page: () => const VerifyEmailView()),

  //! navigationMenu
  GetPage(name: AppRoutes.navigationMenu, page: () => const NavigationMenu()),

  // todo profile
  // GetPage(name: AppRoutes.editProfile, page: () => const EditProfileView()),
  // GetPage(
  //     name: AppRoutes.changePassword, page: () => const ChangePasswordView()),
  // GetPage(name: AppRoutes.settings, page: () => const SettingsView()),

  // GetPage(name: AppRoutes.helpChat, page: () => const HelpChatView()),

  // //! profile > settings
  // GetPage(name: AppRoutes.changeTheme, page: () => const ChangeThemeView()),
  // GetPage(
  //     name: AppRoutes.manageLanguage, page: () => const ManageLanguageView()),

  // //! profile > more options
  // GetPage(name: AppRoutes.rateUs, page: () => const RateUsView()),
  // GetPage(name: AppRoutes.faq, page: () => const FAQView()),
  // GetPage(name: AppRoutes.shareTheApp, page: () => const ShareAppView()),

  // // todo Education
  // GetPage(name: AppRoutes.educationView, page: () => const EducationView()),
  // GetPage(
  //     name: AppRoutes.registerForEducationView,
  //     page: () => const RegisterForEducationView()),

  // todo home
  // GetPage(name: AppRoutes.rightsView, page: () => RightsView())
];
