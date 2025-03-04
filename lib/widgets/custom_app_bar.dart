import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 114, 219, 184),
                Color.fromARGB(255, 87, 151, 199)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10, // Material 2の場合に備えて設定
        scrolledUnderElevation: 10.0, // スクロール時の高さ
        shadowColor: Colors.black, // 影の色
        surfaceTintColor: Colors.transparent, // サーフェスの色合い
        title: title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.labelLarge,
              )
            : Container(),
        actions: actions ?? []);
  }
}
