import 'package:financ/views/statistics_screen/views/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../data/model/news_model.dart';
import '../../operation/views/finance_screen.dart';
import '../../settings/views/settings_screen.dart';
import '../../synopsys/views/synopsys_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> homeWidgets = [
    SynopsysScreen(),
    StatisticScreen(),
    SettingsScreen(),
    // const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: homeWidgets[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/finance.svg',
              width: size.height * 0.032,
              height: size.height * 0.032,
              color: currentIndex == 0
                  ? AppColors.purpleColor
                  : AppColors.lightGreyColor,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/statistics.svg',
              width: size.height * 0.032,
              height: size.height * 0.032,
              color: currentIndex == 1
                  ? AppColors.purpleColor
                  : AppColors.lightGreyColor,
            ),
            label: 'news',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: size.height * 0.032,
                height: size.height * 0.032,
                color: currentIndex == 2
                    ? AppColors.purpleColor
                    : AppColors.lightGreyColor,
              ),
              label: 'game'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        //   backgroundColor: AppColors.blackColor,
        unselectedItemColor: AppColors.whiteColor,
        selectedItemColor: AppColors.orangeColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
            // color: AppColors.lightBlueColor,
            ),
        unselectedLabelStyle: const TextStyle(
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
