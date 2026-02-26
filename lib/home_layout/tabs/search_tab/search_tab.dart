import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/home_layout/tabs/search_tab/appbar/appbar_widget.dart';
import 'package:movie_app/home_layout/tabs/search_tab/content/content_screen.dart';
import '../../../core/responsive/size_config.dart';
import '../home_tab/cubit/home_tab_cubit.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (_) => HomeTabCubit()..getMovies(),
      child: const Scaffold(
        appBar: AppBarWidget(),
        body: ContentScreen(),
      ),
    );
  }
}
