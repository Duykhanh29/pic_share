import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_bidings.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NavBottomBindinngs(),
      initialRoute: Routes.root,
      getPages: AppPages.pages,
      fallbackLocale: const Locale('en', 'UK'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Get.locale,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        return ResponsiveBreakpoints.builder(
          child: MediaQuery(
            data: MediaQuery.of(context),
            child: child!,
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 480, name: MOBILE),
            const Breakpoint(start: 481, end: 800, name: PHONE),
            const Breakpoint(start: 801, end: 1200, name: TABLET),
            const Breakpoint(start: 1201, end: 1920, name: DESKTOP),
          ],
        );
      },
    );
  }
}
