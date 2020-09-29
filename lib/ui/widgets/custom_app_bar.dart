import 'package:flutter/material.dart';

import '../../enums/filters_enum.dart';

import 'actions_app_bar.dart';

class CustomAppBar extends StatelessWidget {
  final int length;
  final Widget child;
  final Duration duration;

  const CustomAppBar({Key key, this.length, this.child, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: false,
      collapsedHeight: 66,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      floating: true,
      flexibleSpace: AnimatedPadding(
        duration: duration,
        padding: length == 0
            ? const EdgeInsets.fromLTRB(12, 10, 12, 0)
            : const EdgeInsets.all(0),
        curve: Curves.decelerate,
        child: AnimatedContainer(
          curve: Curves.decelerate,
          height: length == 0 ? 49 : 65,
          duration: duration,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(length == 0 ? 8 : 0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 3,
                spreadRadius: -0.2,
                offset: Offset(2, 0),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 3,
                spreadRadius: -0.2,
                offset: Offset(-2, 0),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: duration,
            child: length == 0
                ? child
                : ActionsAppBar(
                    length: length,
                    currentFilter: Filters.Individual,
                  ),
          ),
        ),
      ),
    );
  }
}
