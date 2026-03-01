import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/home_layout/tabs/explore_tab/appbar/appbar_widget.dart';
import 'package:movie_app/home_layout/tabs/explore_tab/content/content_explore_screen.dart';
import '../../../core/responsive/size_config.dart';
import '../home_tab/cubit/home_tab_cubit.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
      SizeConfig.init(context);

      return BlocProvider(
        create: (_) => HomeTabCubit()..getMoviesByGenre(),
        child: const Scaffold(
          appBar: AppBarExploreWidget(),
          body: ContentExploreScreen(),
        ),
      );
    }
}