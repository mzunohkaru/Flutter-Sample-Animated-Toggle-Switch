import 'dart:math';

import 'package:anim_toggle/utils.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'crazy_switch.dart';
import 'load_switch.dart';

class SwitchPackagesAnimatedToggleSwitch extends StatefulWidget {
  const SwitchPackagesAnimatedToggleSwitch({super.key});

  @override
  State<SwitchPackagesAnimatedToggleSwitch> createState() =>
      _SwitchPackagesAnimatedToggleSwitchState();
}

class _SwitchPackagesAnimatedToggleSwitchState
    extends State<SwitchPackagesAnimatedToggleSwitch> {
  int value = 0;
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Switch inspired by package '),
              TextSpan(
                  text: 'lite_rolling_switch',
                  style: tappableTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(liteRollingSwitchUrl))
            ]),
          ),
        ),
        DefaultTextStyle.merge(
          style: const TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          child: IconTheme.merge(
            data: IconThemeData(color: Colors.white),
            child: AnimatedToggleSwitch<bool>.dual(
              current: positive,
              first: false,
              second: true,
              spacing: 45.0,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              style: const ToggleStyle(
                borderColor: Colors.transparent,
                indicatorColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              styleBuilder: (value) => ToggleStyle(
                  backgroundColor: value ? kGreen : Colors.red[800]),
              borderWidth: 6.0,
              height: 60.0,
              loadingIconBuilder: (context, global) =>
                  CupertinoActivityIndicator(
                      color:
                          Color.lerp(Colors.red[800], kGreen, global.position)),
              onChanged: (b) => setState(() => positive = b),
              iconBuilder: (value) => value
                  ? const Icon(Icons.lightbulb_outline_rounded,
                      color: kGreen, size: 28.0)
                  : Icon(Icons.power_settings_new_rounded,
                      color: Colors.red[800], size: 30.0),
              textBuilder: (value) => value
                  ? const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Active'))
                  : const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text('Inactive')),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Switch inspired by package '),
              TextSpan(
                  text: 'toggle_switch',
                  style: tappableTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(toggleSwitchUrl))
            ]),
          ),
        ),
        AnimatedToggleSwitch<int>.size(
          current: min(value, 2),
          style: ToggleStyle(
            backgroundColor: const Color(0xFF919191),
            indicatorColor: const Color(0xFFEC3345),
            borderColor: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            indicatorBorderRadius: BorderRadius.zero,
          ),
          values: const [0, 1, 2],
          iconOpacity: 1.0,
          selectedIconScale: 1.0,
          indicatorSize: const Size.fromWidth(100),
          iconAnimationType: AnimationType.onHover,
          styleAnimationType: AnimationType.onHover,
          spacing: 2.0,
          customSeparatorBuilder: (context, local, global) {
            final opacity = ((global.position - local.position).abs() - 0.5)
                .clamp(0.0, 1.0);
            return VerticalDivider(
                indent: 10.0,
                endIndent: 10.0,
                color: Colors.white38.withOpacity(opacity));
          },
          customIconBuilder: (context, local, global) {
            final text = const ['not', 'only', 'icons'][local.index];
            return Center(
                child: Text(text,
                    style: TextStyle(
                        color: Color.lerp(Colors.black, Colors.white,
                            local.animationValue))));
          },
          borderWidth: 0.0,
          onChanged: (i) => setState(() => value = i),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Switch inspired by '),
              TextSpan(
                  text: 'Crazy Switch',
                  style: tappableTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(crazySwitchUrl))
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: CrazySwitch(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Switch inspired by '),
              TextSpan(
                  text: 'load_switch',
                  style: tappableTextStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(loadSwitchUrl))
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: LoadSwitch(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'You can make any other switch with CustomAnimatedToggleSwitch:',
          ),
        ),
        CustomAnimatedToggleSwitch<bool>(
          current: positive,
          values: const [false, true],
          spacing: 0.0,
          indicatorSize: Size.square(30.0),
          animationDuration: const Duration(milliseconds: 200),
          animationCurve: Curves.linear,
          onChanged: (b) => setState(() => positive = b),
          iconBuilder: (context, local, global) {
            return const SizedBox();
          },
          cursors: const ToggleCursors(defaultCursor: SystemMouseCursors.click),
          onTap: (_) => setState(() => positive = !positive),
          iconsTappable: false,
          wrapperBuilder: (context, global, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    left: 10.0,
                    right: 10.0,
                    height: 20.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.black26,
                            Theme.of(context).colorScheme.background,
                            global.position),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                    )),
                child,
              ],
            );
          },
          foregroundIndicatorBuilder: (context, global) {
            return SizedBox.fromSize(
              size: global.indicatorSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.lerp(Colors.white,
                      Theme.of(context).primaryColor, global.position),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 0.05,
                        blurRadius: 1.1,
                        offset: Offset(0.0, 0.8))
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
