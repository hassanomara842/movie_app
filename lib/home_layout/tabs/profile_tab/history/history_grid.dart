import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../cubit/profile_cubit.dart';
import '../../../../cubit/profile_states.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_card.dart';
import '../../../../widgets/app_dialog_widget.dart';

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
          final movies = state.movies;
          if (movies.isEmpty) {
            return _buildEmptyState(context);
          }
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "watch_history".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _showClearConfirmation(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                      icon: Icon(Icons.delete_sweep, size: 20.sp),
                      label: Text(
                        "clear".tr(),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.movieDetailsScreen,
                          arguments: movie.id,
                        ).then((_) {
                          if (context.mounted) {
                            context.read<ProfileCubit>().getWatchHistory();
                          }
                        });
                      },
                      child: AbsorbPointer(
                        child: MovieCard(movie: movie),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is GetWatchHistoryErrorState) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showClearConfirmation(BuildContext context) {
    AppDialog.show(
      context: context,
      title: "clear_history".tr(),
      message: "clear_history_confirmation".tr(),
      confirmText: "clear".tr(),
      cancelText: "cancel".tr(),
      onConfirm: () {
        context.read<ProfileCubit>().clearHistory();
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.popcornImage, width: 150.w),
          SizedBox(height: 20.h),
          Text(
            "no_history_yet".tr(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
