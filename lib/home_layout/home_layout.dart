import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import '../core/image/app_assets.dart';
import '../core/responsive/size_config.dart';
import '../di/injection.dart';
import 'cubit/home_layout_cubit.dart';
import 'cubit/home_layout_states.dart';
import 'tabs/home_tab/cubit/home_tab_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeLayoutCubit>()),
        BlocProvider(
          create: (context) => getIt<HomeTabCubit>()
            ..getMovies()
            ..getMoviesByGenre(0)
            ..getMoviesByGenre(1)
            ..getMoviesByGenre(2)
            ..getMoviesByGenre(3),
        ),
      ],
      child: BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
        builder: (context, state) {
          var cubit = context.read<HomeLayoutCubit>();
          var homeTabCubit = context.read<HomeTabCubit>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                cubit.pages[cubit.selectedIndex],
                MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: Padding(
                    padding: EdgeInsets.all(h(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: cubit.selectedIndex,
                          onTap: (index) {
                            if (index == 0 && cubit.selectedIndex != 0) {
                              homeTabCubit.refreshHomeCategories();
                            }
                            cubit.changeIndex(index);
                          },
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          items: [
                            buildBottomNavigationBarItem(
                                label: 'Home', icon: AppAssets.homeIcon),
                            buildBottomNavigationBarItem(
                                label: 'search', icon: AppAssets.searchIcon),
                            buildBottomNavigationBarItem(
                                label: 'Explore', icon: AppAssets.exploreIcon),
                            buildBottomNavigationBarItem(
                                label: 'Profile', icon: AppAssets.profileIcon),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      {required String label, required String icon}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(icon)), label: label);
  }
}
