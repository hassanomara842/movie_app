import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/image/app_assets.dart';
import '../../../../../core/responsive/size_config.dart';
import '../../../../../core/text/app_text.dart';
import '../../../../../cubit/profile_cubit.dart';
import '../../../../../cubit/profile_states.dart';
import 'history_grid.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    context.read<ProfileCubit>().getWatchHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: theme.canvasColor,
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
                    }
                  },
                  indicatorColor: theme.cardColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: theme.cardColor,
                  unselectedLabelColor: theme.splashColor,
                  labelStyle: AppText.boldText(color: theme.cardColor, fontSize: 16.sp),
                  unselectedLabelStyle: AppText.boldText(color: theme.splashColor, fontSize: 16.sp),
                  tabs: [
                    Tab(
                      height: 70.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.list, size: 32),
                          const SizedBox(height: 4),
                          Text('wish_list'.tr()),
                        ],
                      ),
                    ),
                    Tab(
                      height: 70.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.folder, size: 32),
                          const SizedBox(height: 4),
                          Text('history'.tr()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    SizedBox.shrink(),
                    HistoryTabBody(),
                  ],
                ),
              ),
            ],
          ),
          MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Theme(
                  data: theme.copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: 3,
                    onTap: (index) {
                      if (index != 3) {
                        Navigator.pop(context);
                      }
                    },
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      buildBottomNavigationBarItem(label: 'Home', icon: AppAssets.homeIcon),
                      buildBottomNavigationBarItem(label: 'search', icon: AppAssets.searchIcon),
                      buildBottomNavigationBarItem(label: 'Explore', icon: AppAssets.exploreIcon),
                      buildBottomNavigationBarItem(label: 'Profile', icon: AppAssets.profileIcon),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({required String label, required String icon}) {
    return BottomNavigationBarItem(icon: ImageIcon(AssetImage(icon)), label: label);
  }
}
///hassan