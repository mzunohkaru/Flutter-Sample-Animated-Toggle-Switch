import 'dart:math';

import 'package:anim_toggle/utils.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAnimatedToggleSwitch extends StatefulWidget {
  const BasicAnimatedToggleSwitch({super.key});

  @override
  State<BasicAnimatedToggleSwitch> createState() =>
      _BasicAnimatedToggleSwitchState();
}

class _BasicAnimatedToggleSwitchState extends State<BasicAnimatedToggleSwitch> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1
        AnimatedToggleSwitch<bool>.dual(
          current: positive,
          first: false,
          second: true,
          spacing: 50.0,
          style: const ToggleStyle(
            borderColor: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          borderWidth: 5.0,
          height: 55,
          onChanged: (b) => setState(() => positive = b),
          styleBuilder: (b) =>
              ToggleStyle(indicatorColor: b ? Colors.red : Colors.green),
          iconBuilder: (value) => value
              ? const Icon(Icons.coronavirus_rounded)
              : const Icon(Icons.tag_faces_rounded),
          textBuilder: (value) => value
              ? const Center(child: Text('Oh no...'))
              : const Center(child: Text('Nice :)')),
        ),
        const SizedBox(height: 16.0),
        // 2
        AnimatedToggleSwitch<bool>.dual(
          current: positive,
          first: false,
          second: true,
          spacing: 50.0,
          style: const ToggleStyle(
            borderColor: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          borderWidth: 5.0,
          height: 55,
          onChanged: (b) => setState(() => positive = b),
          styleBuilder: (b) => ToggleStyle(
            backgroundColor: b ? Colors.white : Colors.black,
            indicatorColor: b ? Colors.blue : Colors.red,
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(4.0), right: Radius.circular(50.0)),
            indicatorBorderRadius: BorderRadius.circular(b ? 50.0 : 4.0),
          ),
          iconBuilder: (value) => Icon(
            value
                ? Icons.access_time_rounded
                : Icons.power_settings_new_rounded,
            size: 32.0,
            color: value ? Colors.black : Colors.white,
          ),
          textBuilder: (value) => value
              ? const Center(
                  child: Text('On', style: TextStyle(color: Colors.black)))
              : const Center(
                  child: Text('Off', style: TextStyle(color: Colors.white))),
        ),
        const SizedBox(height: 16.0),
        // 3
        DefaultTextStyle.merge(
          style: const TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          child: IconTheme.merge(
            data: const IconThemeData(color: Colors.white),
            child: AnimatedToggleSwitch<bool>.dual(
              current: positive,
              first: false,
              second: true,
              spacing: 45.0,
              animationDuration: const Duration(milliseconds: 600),
              style: const ToggleStyle(
                borderColor: Colors.transparent,
                indicatorColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              customStyleBuilder: (context, local, global) {
                if (global.position <= 0.0) {
                  return ToggleStyle(backgroundColor: Colors.red[800]);
                }
                return ToggleStyle(
                    backgroundGradient: LinearGradient(
                  colors: [kGreen, Colors.red[800]!],
                  stops: [
                    global.position -
                        (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                    global.position + max(0, 2 * (global.position - 0.5)) * 0.7,
                  ],
                ));
              },
              borderWidth: 6.0,
              height: 60.0,
              loadingIconBuilder: (context, global) =>
                  CupertinoActivityIndicator(
                      color:
                          Color.lerp(Colors.red[800], kGreen, global.position)),
              onChanged: (b) => setState(() => positive = b),
              iconBuilder: (value) => value
                  ? const Icon(Icons.power_outlined, color: kGreen, size: 32.0)
                  : Icon(Icons.power_settings_new_rounded,
                      color: Colors.red[800], size: 32.0),
              textBuilder: (value) => value
                  ? const Center(child: Text('Active'))
                  : const Center(child: Text('Inactive')),
            ),
          ),
        ),
      ],
    );
  }
}
