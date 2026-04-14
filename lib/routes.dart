import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/modules/auth/choose_auth_method/view/choose_auth_method_view.dart';
import 'package:chimay_house/modules/auth/forget_password/view/forget_password_view.dart';
import 'package:chimay_house/modules/auth/sign_in/view/sign_in_view.dart';
import 'package:chimay_house/modules/auth/sign_up/view/sign_up_view.dart';
import 'package:chimay_house/modules/auth/success_send_email/view/success_send_email_view.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/view/choose_language_view.dart';
import 'package:chimay_house/modules/auth/verify_email/view/verify_email_view.dart';
import 'package:chimay_house/modules/navigation_menu/view/navigation_menu.dart';
import 'package:chimay_house/modules/auth/on_boarding/view/on_boarding_view.dart';
import 'package:chimay_house/modules/auth/splash/view/splash_view.dart';
import 'package:chimay_house/modules/auth/logic_view/view/logic_view.dart';
import 'package:chimay_house/modules/auth/complete_profile/view/complete_profile_view.dart';
import 'package:chimay_house/modules/auth/waiting_for_activation/view/waiting_for_activation_view.dart';
import 'package:chimay_house/modules/admin/view/admin_view.dart';

List<GetPage<dynamic>>? getPages = [
  //! Auth & Startup
  GetPage(name: AppRoutes.splash, page: () => const SplashView()),
  GetPage(name: AppRoutes.logicView, page: () => const LogicView()),
  GetPage(name: AppRoutes.chooseLanguage, page: () => const ChooseLanguageView()),
  GetPage(name: AppRoutes.onBoarding, page: () => const OnBoardingView()),
  GetPage(name: AppRoutes.chooseAuthMethod, page: () => const ChooseAuthMethodView()),
  GetPage(name: AppRoutes.signIn, page: () => const SignInView()),
  GetPage(name: AppRoutes.signUp, page: () => const SignUpView()),
  GetPage(name: AppRoutes.forgetPassword, page: () => const ForgetPasswordView()),
  GetPage(name: AppRoutes.successSendEmail, page: () => const SuccessSendEmailView()),
  GetPage(name: AppRoutes.verifyEmail, page: () => const VerifyEmailView()),
  
  //! Profile Completion & Status
  
  GetPage(name: AppRoutes.completeProfile, page: () => const CompleteProfileView()),
  GetPage(name: AppRoutes.waitingForActivation, page: () => const WaitingForActivationView()),

  //! Main Application
  GetPage(name: AppRoutes.navigationMenu, page: () => const NavigationMenu()),
  
  //! Admin
  GetPage(name: AppRoutes.adminView, page: () => const AdminView()),
];