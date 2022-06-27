// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:portfolio_app/utils/text_styles.dart';
import 'package:sprung/sprung.dart';

class OnHoverButton extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final Matrix4 transfrom;

  const OnHoverButton({
    Key? key,
    required this.builder,
    required this.transfrom,
  }) : super(key: key);

  @override
  State<OnHoverButton> createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final transform = isHovered ? widget.transfrom : Matrix4.identity();

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
          curve: Sprung.overDamped,
          duration: const Duration(milliseconds: 500),
          transform: transform,
          child: widget.builder(isHovered),
        ));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

class ScrollDownToSeeMore extends StatefulWidget {
  const ScrollDownToSeeMore({Key? key}) : super(key: key);

  @override
  State<ScrollDownToSeeMore> createState() => _ScrollDownToSeeMoreState();
}

class _ScrollDownToSeeMoreState extends State<ScrollDownToSeeMore>
    with SingleTickerProviderStateMixin {
  late AnimationController myAnimationController;

  @override
  void initState() {
    super.initState();
    myAnimationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    myAnimationController.forward();
    if (!myAnimationController.isAnimating) {
      myAnimationController.reverse();
      log('message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: myAnimationController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height - 100),
              Text('Scroll Down To See More', style: lowerTextStyle),
              const SizedBox(height: 10),
              Icon(CupertinoIcons.down_arrow, color: standardTextStyle.color),
            ],
          ),
        ],
      ),
      builder: (context, widget) => Transform.translate(
        offset: Offset(
            myAnimationController.value * 0, myAnimationController.value * 30),
        child: widget,
      ),
    );
  }
}
