import 'package:flutter/material.dart';
import 'package:balance_ai_agent/pages/setting_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({
    super.key,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final List<Widget> appBarActions = [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingPage(),
            ),
          );
        },
      )
    ];

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
        elevation: 5,
        scrolledUnderElevation: 10.0, // スクロール時の高さ
        shadowColor: Colors.black, // 影の色
        surfaceTintColor: Colors.transparent, // サーフェスの色合い
        title: title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.labelLarge,
              )
            : Container(),
        actions: appBarActions);
  }
}
