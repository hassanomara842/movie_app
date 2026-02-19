import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/image/app_assets.dart';

class AvatarBottomSheet extends StatefulWidget {
  final Function(String) onAvatarSelected;
  final String? selectedAvatar;

  const AvatarBottomSheet({
    super.key,
    required this.onAvatarSelected,
    this.selectedAvatar,
  });

  @override
  State<AvatarBottomSheet> createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  late String selected;

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar,
    AppImages.avatar8,
  ];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedAvatar ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          final avatar = avatars[index];
          final isSelected = avatar == selected;

          return GestureDetector(
            onTap: () {
              setState(() {
                selected = avatar;
              });
              widget.onAvatarSelected(avatar);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).cardColor
                    : Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
