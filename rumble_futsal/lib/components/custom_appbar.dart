import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumble_futsal/utils/config.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.appTitle,
    this.route,
    this.icon,
    this.actions,
    this.color,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60); //default height

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;
  final Color? color; 

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: widget.color ?? Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      //if icon is not set return null
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: Config.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                onPressed: () {
                  if (widget.route != null) {
                    Navigator.of(context).pushNamed(widget.route!);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: widget.icon!,
                iconSize: 16.0,
                color: Colors.white,
              ),
            )
          : null,

      //if action is not set return null

      actions: widget.actions ?? null,
    );
  }
}
