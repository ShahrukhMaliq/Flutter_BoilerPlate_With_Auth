import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LaunchAnimation extends StatelessWidget {
  LaunchAnimation(
      {Key? key, required this.buttonController, required this.pageRoute})
      : buttonSqueezeanimation = Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        buttomZoomOut = Tween(
          begin: 70.0,
          end: 5000,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;
  final PageRouteInfo<dynamic> pageRoute;

  Future<void> _playAnimation() async {
    await buttonController.forward();
    await buttonController.reverse();
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return InkWell(
        onTap: () {
          _playAnimation();
        },
        child: Hero(
            tag: "fade",
            child: Container(
                width: buttomZoomOut.value >= 70
                    ? buttonSqueezeanimation.value
                    : 150,
                height: 40.0,
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                child: buttonSqueezeanimation.value > 75.0
                    ? const Text(
                        "Launch",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300),
                      )
                    : const CircularProgressIndicator(
                        value: null,
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ))));
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        AutoRouter.of(context).push(pageRoute);
        //Navigator.pushNamed(context, pageRoute);
        // Navigator.push(context, pageRoute);
      }
    });
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
