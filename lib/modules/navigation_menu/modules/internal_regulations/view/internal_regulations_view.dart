import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/models/data/internal_regulations_data.dart';
import 'package:chimay_house/models/static/internal_regulations_model.dart';
import 'package:chimay_house/test/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class InternalRegulationsView extends StatelessWidget {
  const InternalRegulationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'internalRegulationsAppBarTitle'.tr, showBack: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              NavigationCard(
                icon: Icons.home,
                title: 'internalRegulationsTitle'.tr,
                description:
                    'internalRegulationsDescription'.tr,
                color: Colors.pinkAccent,
              ),
              ListView.builder(
                itemCount: internalRegulationsData.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InternalRegulationsTimeLine(
                    index: index,
                    internalRegulationsModel: internalRegulationsData[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} // تأكد من استيراد صفحة ILAHomePage

class NavigationCard extends StatelessWidget {
  const NavigationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ILAHomePage()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha:0.25), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey[isDarkMode ? 300 : 700],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slide(duration: 400.ms);
  }
}

class InternalRegulationsTimeLine extends StatelessWidget {
  final InternalRegulationsModel internalRegulationsModel;
  final int index;
  const InternalRegulationsTimeLine({
    super.key,
    required this.index,
    required this.internalRegulationsModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: internalRegulationsModel.color.withValues(alpha: 0.3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: ExpansionTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                collapsedIconColor: isDarkMode
                    ? Colors.grey[400]
                    : Colors.grey[600],
                iconColor: internalRegulationsModel.color,
                leading:
                    Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                internalRegulationsModel.color.withValues(
                                  alpha: 0.7,
                                ),
                                internalRegulationsModel.color,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: internalRegulationsModel.color
                                    .withValues(alpha: 0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            internalRegulationsModel.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        )
                        .animate()
                        .scale(
                          begin: const Offset(0.7, 0.7),
                          duration: 500.ms,
                          curve: Curves.elasticOut,
                        )
                        .then()
                        .shimmer(duration: 2000.ms, delay: 500.ms),
                title:
                    Text(
                          internalRegulationsModel.title.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                        .animate()
                        .slideX(
                          begin: -0.2,
                          duration: 500.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .fadeIn(duration: 600.ms),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: ListView.builder(
                      itemCount: internalRegulationsModel
                          .internalRegulationsDepartments
                          .length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            internalRegulationsModel
                                                .internalRegulationsDepartments[index]
                                                .departmentColor
                                                .withValues(alpha: 0.9),
                                            internalRegulationsModel
                                                .internalRegulationsDepartments[index]
                                                .departmentColor,
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: internalRegulationsModel
                                                .internalRegulationsDepartments[index]
                                                .departmentColor
                                                .withValues(alpha: 0.4),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                    .animate()
                                    .scale(
                                      begin: const Offset(0.6, 0.6),
                                      delay: Duration(
                                        milliseconds: index * 100,
                                      ),
                                      duration: 600.ms,
                                      curve: Curves.elasticOut,
                                    )
                                    .fadeIn(
                                      delay: Duration(
                                        milliseconds: index * 100,
                                      ),
                                    ),

                                if (index <
                                    internalRegulationsModel
                                            .internalRegulationsDepartments
                                            .length -
                                        1)
                                  Container(
                                        width: 4,
                                        height: 80,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              internalRegulationsModel
                                                  .internalRegulationsDepartments[index]
                                                  .departmentColor,
                                              internalRegulationsModel
                                                  .internalRegulationsDepartments[index]
                                                  .departmentColor
                                                  .withValues(alpha: 0.6),
                                              internalRegulationsModel
                                                  .internalRegulationsDepartments[index]
                                                  .departmentColor
                                                  .withValues(alpha: 0.4),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(
                                        delay: Duration(
                                          milliseconds: index * 100 + 300,
                                        ),
                                        duration: 400.ms,
                                      )
                                      .scaleY(
                                        begin: 0,
                                        delay: Duration(
                                          milliseconds: index * 100 + 300,
                                        ),
                                        duration: 500.ms,
                                      ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child:
                                  InternalRegulationsSubSectionCard(
                                        internalRegulationsModel:
                                            internalRegulationsModel,
                                        isDarkMode: isDarkMode,
                                        index: index,
                                      )
                                      .animate()
                                      .fadeIn(
                                        delay: Duration(
                                          milliseconds: index * 100 + 200,
                                        ),
                                        duration: 600.ms,
                                      )
                                      .slideX(
                                        begin: 0.3,
                                        delay: Duration(
                                          milliseconds: index * 100 + 200,
                                        ),
                                        duration: 500.ms,
                                      ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: index * 200),
          duration: 600.ms,
        )
        .slideY(begin: 0.2, duration: 500.ms);
  }
}

class InternalRegulationsSubSectionCard extends StatelessWidget {
  final InternalRegulationsModel internalRegulationsModel;

  final bool isDarkMode;
  final int index;

  const InternalRegulationsSubSectionCard({
    super.key,
    required this.internalRegulationsModel,
    required this.isDarkMode,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: internalRegulationsModel
          .internalRegulationsDepartments[index]
          .onTapDepartment,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode
                ? Colors.grey[700]!
                : internalRegulationsModel
                      .internalRegulationsDepartments[index]
                      .departmentColor
                      .withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: internalRegulationsModel
                  .internalRegulationsDepartments[index]
                  .departmentColor
                  .withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: internalRegulationsModel
                            .internalRegulationsDepartments[index]
                            .departmentColor
                            .withValues(alpha: 0.2),

                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        internalRegulationsModel
                            .internalRegulationsDepartments[index]
                            .departmentIcon,
                        color: internalRegulationsModel
                            .internalRegulationsDepartments[index]
                            .departmentColor,
                        size: 24,
                      ),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .then()
                    .shimmer(duration: 1500.ms, delay: 500.ms),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    internalRegulationsModel
                        .internalRegulationsDepartments[index]
                        .departmentTitle.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).animate().slideX(begin: -0.2, duration: 400.ms).fadeIn(),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
                  internalRegulationsModel
                      .internalRegulationsDepartments[index]
                      .departmentDescription.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                )
                .animate(delay: 100.ms)
                .slideY(begin: 0.2, duration: 400.ms)
                .fadeIn(),
            SizedBox(height: 10),
            Row(
                  children: [
                    Text(
                      'readMoreButton'.tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: internalRegulationsModel
                            .internalRegulationsDepartments[index]
                            .departmentColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      color: internalRegulationsModel
                          .internalRegulationsDepartments[index]
                          .departmentColor,
                    ),
                  ],
                )
                .animate(delay: 100.ms)
                .slideY(begin: 0.2, duration: 400.ms)
                .fadeIn(),
          ],
        ),
      ),
    );
  }
}
