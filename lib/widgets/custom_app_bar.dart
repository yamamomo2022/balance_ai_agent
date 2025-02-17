import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

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
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: title != null
          ? Text(title!, style: Theme.of(context).textTheme.labelLarge)
          : const Text(""),
      actions: actions ?? const <Widget>[],
    );
  }
}
