import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../cubit/profile_cubit.dart';
import '../../../../cubit/profile_states.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_card.dart';

class HistoryTabBody extends StatelessWidget {
  const HistoryTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      buildWhen: (previous, current) =>
      current is GetWatchHistoryLoadingState ||
          current is GetWatchHistorySuccessState ||
          current is GetWatchHistoryErrorState,
      builder: (context, state) {
        if (state is GetWatchHistoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetWatchHistorySuccessState) {
          if (state.movies.isEmpty) {
            return _buildEmptyState(context);
          }
          return GridView.builder(
            padding: EdgeInsets.all(15.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) => MovieCard(movie: state.movies[index]),
          );
        } else if (state is GetWatchHistoryErrorState) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Image.asset(AppAssets.popcornImage, width: 150.w),
    );
  }
}
///hassan
