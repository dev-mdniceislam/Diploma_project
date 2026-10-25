import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_feed_section.dart';
import '../widgets/home_hero.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AppDialog(
  //           title: 'Please Login Now',
  //           child: Center(
  //             child: CustomButton(
  //               label: "Login",
  //               onPressed: () {
  //                 context.pop(); // ডায়ালগ বন্ধ করুন
  //                 context.go(AppRoutes.auth); // লগইন পেজে যান
  //               },
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHero(),
        HomeFeedSection(onApply: (value) {}),
      ],
    );
  }
}
