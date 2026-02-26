import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/text/app_text.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../cubit/search_tab_cubit.dart';
import '../cubit/search_tab_states.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, h(70));
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: h(70),
        title: BlocBuilder<SearchTabCubit, SearchTabStates>(
          builder: (BuildContext context, state) {
            return CustomTextFormField(
              hintText: "Search",
              autofillHints: const [AutofillHints.name],
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                context.read<SearchTabCubit>().changeSearchText(value);
              },
              cursorColor: Theme.of(context).splashColor,
              style: AppText.regularTextRoboto(
                  color: Theme.of(context).splashColor, fontSize: 16.sp),
              hintStyle: AppText.regularTextRoboto(
                  color: Theme.of(context).splashColor, fontSize: 16.sp),
              prefixIcon: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? AppAssets.searchIconDark
                    : AppAssets.searchIcon,
              ),
              filled: true,
              fillColor: Theme.of(context).canvasColor,
              contentPadding: EdgeInsets.symmetric(horizontal: w(15)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.w,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.w,
                  )),
            );
          },
        ));
  }
}
