import 'package:chimay_house/models/static/internal_regulations_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/2_our_rules_for_living/2.1_privacy_and_tranquility_and_respect/view/privacy_and_tranquility_and_respect_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/2_our_rules_for_living/2.2_security/view/security_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/2_our_rules_for_living/2.3_cleanliness/view/cleanliness_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/4_sanctions_and_enforcement_measures/4.1_penalties/view/penalties_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/4_sanctions_and_enforcement_measures/4.2_order_of_measures/view/order_of_measures_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.3_medical_and_psychological_assistance/view/medical_and_psychological_assistance_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.2_individual_support/view/individual_support_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.4_pocket_money/view/pocket_money_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.1_providing_basic_services/view/providing_basic_services_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.5_social_cultural_and_sports_activities/view/social_cultural_and_sports_activities_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.1_obligation_to_provide_information/view/obligation_to_provide_information_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.2_financial_contribution_to_reception/view/financial_contribution_to_reception_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.3_schedule_and_keep_appointments/view/schedule_and_keep_appointments_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.4_exercising_parental_authority/view/exercising_parental_authority_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.5_presence_in_the_host_structure/view/presence_in_the_host_structure_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.6_deposit_system/view/deposit_system_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/3_rules_for_organizing_the_hosting/3.7_control_of_the_residence/view/control_of_the_residence_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/5_complaints_and_redress/5.1_filing_a_complaint/view/filing_a_complaint_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/5_complaints_and_redress/5.2_appealing_a_penalty_imposed/view/appealing_a_penalty_imposed_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/5_complaints_and_redress/5.3_appealing_medical_assistance_decisions/view/appealing_medical_assistance_decisions_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<InternalRegulationsModel> internalRegulationsData = [
  InternalRegulationsModel(
    icon: Icons.volunteer_activism,
    title: 'firstInternalRegulationsTitle',
    color: Color(0xff2196f3),
    internalRegulationsDepartments: [
      InternalRegulationsDepartments(
        departmentColor: Color(0xff2196f3),
        departmentTitle: 'firstInternalRegulationsSectionsOneTitle',
        departmentIcon: Icons.home_repair_service,
        departmentDescription:
            'firstInternalRegulationsSectionsOneDescription',
        onTapDepartment: ()=>Get.to(()=>ProvidingBasicServicesView()),
      ),
      InternalRegulationsDepartments(
        departmentColor: Color(0xff2196f3),
        departmentTitle: 'firstInternalRegulationsSectionsTwoTitle',
        departmentIcon: Icons.person_pin_circle,
        departmentDescription:
            'firstInternalRegulationsSectionsTwoDescription',
        onTapDepartment: () {
          Get.to(()=>IndividualSupportView());
        },
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xff2196f3),
        departmentTitle: 'firstInternalRegulationsSectionsThreeTitle',
        departmentIcon: Icons.health_and_safety,
        departmentDescription:
            'firstInternalRegulationsSectionsThreeDescription',
            onTapDepartment: ()=>Get.to(()=>MedicalAndPsychologicalAssistanceView())
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xff2196f3),
        departmentTitle: 'firstInternalRegulationsSectionsForeTitle',
        departmentIcon: Icons.emoji_people,
        departmentDescription:
            'firstInternalRegulationsSectionsForeDescription',
            onTapDepartment: ()=>Get.to(()=>PocketMoneyView())
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xff2196f3),
        departmentTitle: 'firstInternalRegulationsSectionsFiveTitle',
        departmentIcon: Icons.account_balance_wallet,
        departmentDescription:
            'firstInternalRegulationsSectionsFiveDescription',
            onTapDepartment: () => Get.to(()=>SocialCulturalAndSportsActivitiesView()),
      ),
    ],
  ),

  InternalRegulationsModel(
    icon: Icons.rule_folder,
    title: 'secondInternalRegulationsTitle',
    color: Color(0xff4caf50),
    internalRegulationsDepartments: [
      InternalRegulationsDepartments(
        departmentColor: Color(0xff4caf50),
        departmentTitle: 'secondInternalRegulationsSectionsOneTitle',
        departmentIcon: Icons.clean_hands,
        departmentDescription:
            'secondInternalRegulationsSectionsOneDescription',
            onTapDepartment:()=> Get.to(()=>PrivacyAndTranquilityAndRespectView())
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xff4caf50),
        departmentTitle: 'secondInternalRegulationsSectionsTwoTitle',
        departmentIcon: Icons.self_improvement,
        departmentDescription:
            'secondInternalRegulationsSectionsTwoDescription',
            onTapDepartment: () => Get.to(()=>SecurityView()),

      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xff4caf50),
        departmentTitle: 'secondInternalRegulationsSectionsThreeTitle',
        departmentIcon: Icons.security,
        departmentDescription:
            'secondInternalRegulationsSectionsThreeDescription',
            onTapDepartment: () => Get.to(()=>CleanlinessView()),
      ),
    ],
  ),

  InternalRegulationsModel(
    icon: Icons.account_balance,
    title: 'thirdInternalRegulationsTitle',
    color: Color(0xffffc107),
    internalRegulationsDepartments: [
      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsOneTitle',
        departmentIcon: Icons.fact_check,
        departmentDescription:
            'thirdInternalRegulationsSectionsOneDescription',
            onTapDepartment: () => Get.to(()=>ObligationToProvideInformationView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsTwoTitle',
        departmentIcon: Icons.attach_money,
        departmentDescription:
            'thirdInternalRegulationsSectionsTwoDescription',
            onTapDepartment: ()=>Get.to(()=>FinancialContributionToReceptionView())
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsThreeTitle',
        departmentIcon: Icons.schedule,
        departmentDescription:
            'thirdInternalRegulationsSectionsThreeDescription',
            onTapDepartment: () => Get.to(()=>ScheduleAndKeepAppointmentsView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsForeTitle',
        departmentIcon: Icons.family_restroom,
        departmentDescription:
            'thirdInternalRegulationsSectionsForeDescription',
            onTapDepartment: () => Get.to(()=>ExercisingParentalAuthorityView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsFiveTitle',
        departmentIcon: Icons.home,
        departmentDescription:
            'thirdInternalRegulationsSectionsFiveDescription',
            onTapDepartment: () => Get.to(()=>PresenceInTheHostStructureView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsSixTitle',
        departmentIcon: Icons.inventory_2,
        departmentDescription:
            'thirdInternalRegulationsSectionsSixDescription',
            onTapDepartment: () => Get.to(()=>DepositSystemView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xffffc107),
        departmentTitle: 'thirdInternalRegulationsSectionsSevenTitle',
        departmentIcon: Icons.meeting_room,
        departmentDescription:
            'thirdInternalRegulationsSectionsSevenDescription',
            onTapDepartment: () => Get.to(()=>ControlOfTheResidenceView()),
      ),
    ],
  ),

  InternalRegulationsModel(
    icon: Icons.gavel,
    title: 'forthInternalRegulationsTitle',
    color: Color(0xfff44336),
    internalRegulationsDepartments: [
      InternalRegulationsDepartments(
        departmentColor: Color(0xfff44336),
        departmentTitle: 'forthInternalRegulationsSectionsOneTitle',
        departmentIcon: Icons.warning_amber,
        departmentDescription:
            'forthInternalRegulationsSectionsOneDescription',
            onTapDepartment: () => Get.to(()=>PenaltiesView()),
      ),

      InternalRegulationsDepartments(
        departmentColor: Color(0xfff44336),
        departmentTitle: 'forthInternalRegulationsSectionsTwoTitle',
        departmentIcon: Icons.rule,
        departmentDescription:
            'forthInternalRegulationsSectionsTwoDescription',
            onTapDepartment: () => Get.to(()=>OrderOfMeasuresView()),
      ),
    ],
  ),

  InternalRegulationsModel(
    icon: Icons.support_agent,
    title: 'fifthInternalRegulationsTitle',
    color: Color(0xff9c27b0),
    internalRegulationsDepartments: [
      InternalRegulationsDepartments(
        departmentColor: Color(0xff9c27b0),
        departmentTitle: 'fifthInternalRegulationsSectionsOneTitle',
        departmentIcon: Icons.feedback,
        departmentDescription:
            'fifthInternalRegulationsSectionsOneDescription',
            onTapDepartment: () => Get.to(()=>FilingAComplaintView()),
      ),
      InternalRegulationsDepartments(
        departmentColor: Color(0xff9c27b0),
        departmentTitle: 'fifthInternalRegulationsSectionsTwoTitle',
        departmentIcon: Icons.record_voice_over,
        departmentDescription:
            'fifthInternalRegulationsSectionsTwoDescription',
            onTapDepartment: () => Get.to(()=>AppealingAPenaltyImposedView()),
      ),
      InternalRegulationsDepartments(
        departmentColor: Color(0xff9c27b0),
        departmentTitle: 'fifthInternalRegulationsSectionsThreeTitle',
        departmentIcon: Icons.local_hospital,
        departmentDescription:
            'fifthInternalRegulationsSectionsThreeDescription',
            onTapDepartment: () => Get.to(()=>AppealingMedicalAssistanceDecisionsView()),
      ),
    ],
  ),
];

final regulationSections = [
  {
    "id": 1,
    "title": "خدماتنا",
    "icon": Icons.volunteer_activism,
    "color": Color(0xFF2196F3),
    "subSections": [
      {
        "title": "تقديم الخدمات الأساسية",
        "description":
            "نوفر للمقيمين الخدمات الضرورية مثل المأوى، الطعام، المياه، والكهرباء لضمان حياة كريمة وآمنة.",
        "icon": Icons.home_repair_service,
      },
      {
        "title": "الدعم الفردي",
        "description":
            "كل شخص يحصل على متابعة خاصة لمساعدته في أموره اليومية والإدارية والتعليمية.",
        "icon": Icons.person_pin_circle,
      },
      {
        "title": "المساعدة الطبية والنفسية",
        "description":
            "نوفر الوصول إلى الرعاية الصحية والدعم النفسي لمن يحتاجه لضمان سلامة الجميع.",
        "icon": Icons.health_and_safety,
      },
      {
        "title": "الأنشطة الاجتماعية والثقافية والرياضية",
        "description":
            "نقيم فعاليات ترفيهية وثقافية ورياضية لتعزيز الاندماج وبناء علاقات مجتمعية إيجابية.",
        "icon": Icons.emoji_people,
      },
      {
        "title": "مصاريف الجيب (Pocket Money)",
        "description":
            "يحصل كل مقيم على مبلغ أسبوعي بسيط لتغطية احتياجاته الشخصية، ويتم تحديد المبلغ حسب فئته (عازب أو عائلة) وفق اللوائح الرسمية.",
        "icon": Icons.account_balance_wallet,
      },
    ],
  },
  {
    "id": 2,
    "title": "قواعدنا للعيش معنا",
    "icon": Icons.rule_folder,
    "color": Color(0xFF4CAF50),
    "subSections": [
      {
        "title": "النظافة",
        "description":
            "يجب الحفاظ على نظافة الغرفة والأماكن المشتركة يوميًا للمحافظة على بيئة صحية للجميع.",
        "icon": Icons.clean_hands,
      },
      {
        "title": "الخصوصية والهدوء واحترام الإقامة",
        "description":
            "احترم خصوصية الآخرين وابتعد عن الضوضاء خاصة في أوقات الراحة.",
        "icon": Icons.self_improvement,
      },
      {
        "title": "الأمن",
        "description":
            "يُمنع إدخال الغرباء دون إذن الإدارة. أغلق الأبواب وتأكد من سلامة المكان دائمًا.",
        "icon": Icons.security,
      },
    ],
  },
  {
    "id": 3,
    "title": "تنظيم هيكل الاستضافة",
    "icon": Icons.account_balance,
    "color": Color(0xFFFFC107),
    "subSections": [
      {
        "title": "الالتزام بتقديم المعلومات",
        "description":
            "يجب تزويد الإدارة بجميع المعلومات الشخصية الدقيقة وتحديثها عند حدوث أي تغيير.",
        "icon": Icons.fact_check,
      },
      {
        "title": "المساهمة المالية في الاستقبال",
        "description":
            "يطلب من بعض المقيمين المساهمة بجزء بسيط لتغطية تكاليف الإقامة حسب إمكانياتهم.",
        "icon": Icons.attach_money,
      },
      {
        "title": "تحديد المواعيد والالتزام بها",
        "description":
            "احترم المواعيد المحددة للقاءات الإدارية والمواعيد الطبية.",
        "icon": Icons.schedule,
      },
      {
        "title": "ممارسة السلطة الأبوية",
        "description":
            "الأهل مسؤولون عن أولادهم داخل السكن، ويجب مراقبتهم وضمان سلامتهم.",
        "icon": Icons.family_restroom,
      },
      {
        "title": "التواجد في بنية المضيف",
        "description":
            "يجب إعلام الإدارة عند المغادرة المؤقتة أو الطويلة وتحديد مدة الغياب.",
        "icon": Icons.home,
      },
      {
        "title": "نظام الإيداع",
        "description":
            "عند استلام أو تسليم الأغراض، يتم تسجيلها رسميًا لتفادي أي التباس.",
        "icon": Icons.inventory_2,
      },
      {
        "title": "التحكم في غرفة الإقامة وخزانة الملابس الخاصة",
        "description":
            "كل غرفة وخزانة تعتبر ملكية عامة، يُمنع التعديل أو التخريب أو الاستعمال المفرط.",
        "icon": Icons.meeting_room,
      },
    ],
  },
  {
    "id": 4,
    "title": "العقوبات وتدابير التنفيذ",
    "icon": Icons.gavel,
    "color": Color(0xFFF44336),
    "subSections": [
      {
        "title": "العقوبات",
        "description":
            "تُفرض العقوبات عند مخالفة القواعد أو التسبب في ضرر للمكان أو المقيمين الآخرين.",
        "icon": Icons.warning_amber,
      },
      {
        "title": "ترتيب التدابير",
        "description":
            "تبدأ الإجراءات من التنبيه الشفهي وصولاً إلى نقل الإقامة في حال تكرار المخالفات.",
        "icon": Icons.rule,
      },
    ],
  },
  {
    "id": 5,
    "title": "الشكاوى والانتصاف",
    "icon": Icons.support_agent,
    "color": Color(0xFF9C27B0),
    "subSections": [
      {
        "title": "تقديم الشكوى",
        "description":
            "يمكنك تقديم شكوى رسمية إلى الإدارة في حال حدوث أي مشكلة أو سوء معاملة.",
        "icon": Icons.feedback,
      },
      {
        "title": "الاستئناف ضد العقوبة المفروضة",
        "description": "للمقيم الحق في طلب مراجعة العقوبة من قبل لجنة مستقلة.",
        "icon": Icons.record_voice_over,
      },
      {
        "title": "الطعون على قرارات المساعدة الطبية",
        "description":
            "إذا تم رفض أو تقليص المساعدة الطبية، يمكنك الطعن في القرار رسميًا.",
        "icon": Icons.local_hospital,
      },
    ],
  },
];
