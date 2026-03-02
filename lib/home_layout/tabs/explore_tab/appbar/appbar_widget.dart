import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/home_layout/tabs/explore_tab/appbar/tab_item.dart';
import '../../../../core/responsive/responsive.dart';
import '../../home_tab/cubit/home_tab_cubit.dart';
import '../../home_tab/cubit/home_tab_states.dart';

class AppBarExploreWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const AppBarExploreWidget({super.key});

  @override
  State<AppBarExploreWidget> createState() => _AppBarExploreWidgetState();

  @override
  Size get preferredSize => Size(double.infinity, h(70));
}

class _AppBarExploreWidgetState extends State<AppBarExploreWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabCubit, HomeTabStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<HomeTabCubit>(context);

        return AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: h(70),
          title: DefaultTabController(
            length: cubit.genres.length,
            child: TabBar(
              onTap: (index) {
                // Pass the specific genre to the cubit
                cubit.getMoviesByGenre(cubit.genres[index]);
              },
              isScrollable: true,
              dividerColor: AppColors.transparentColor,
              indicatorColor: AppColors.transparentColor,
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.symmetric(horizontal: w(5)),
              tabs: List.generate(cubit.genres.length, (index) {
                return TabItem(
                  text: cubit.genres[index],
                  isSelected: cubit.currentGenre == cubit.genres[index],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
