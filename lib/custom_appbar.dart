import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE7ECEF);
    return AppBar(
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(-2,-4),
                blurRadius: 1,
                inset: false,

              ),
              BoxShadow(
                color: Color(0xFFA7A9AF),
                offset: Offset(2,2),
                blurRadius: 1,
                spreadRadius: 1,
                inset: false,
              ),
            ]
        ),
        child:  Text(widget.title,  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
