import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingAnimatedToggleSwitch extends StatefulWidget {
  const LoadingAnimatedToggleSwitch({super.key});

  @override
  State<LoadingAnimatedToggleSwitch> createState() =>
      _LoadingAnimatedToggleSwitchState();
}

class _LoadingAnimatedToggleSwitchState
    extends State<LoadingAnimatedToggleSwitch> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 4
        DefaultTextStyle.merge(
          style: const TextStyle(color: Colors.white),
          child: IconTheme.merge(
            data: const IconThemeData(color: Colors.white),
            child: AnimatedToggleSwitch<bool>.dual(
              current: positive,
              first: false,
              second: true,
              spacing: 45.0,
              style: const ToggleStyle(
                borderColor: Colors.transparent,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0.5),
                  ),
                ],
              ),
              borderWidth: 10.0,
              height: 50,
              loadingIconBuilder: (context, global) =>
                  const CupertinoActivityIndicator(color: Colors.white),
              onChanged: (b) {
                setState(() => positive = b);
                return Future<dynamic>.delayed(const Duration(seconds: 2));
              },
              styleBuilder: (b) =>
                  ToggleStyle(indicatorColor: b ? Colors.purple : Colors.green),
              iconBuilder: (value) => value
                  ? const Icon(Icons.coronavirus_rounded)
                  : const Icon(Icons.tag_faces_rounded),
              textBuilder: (value) => value
                  ? const Center(
                      child: Text('Oh no...',
                          style: TextStyle(color: Colors.white)))
                  : const Center(child: Text('Nice :)')),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // 5
        AnimatedToggleSwitch<bool>.dual(
          current: positive,
          first: false,
          second: true,
          spacing: 45.0,
          animationDuration: const Duration(milliseconds: 600),
          style: const ToggleStyle(
            borderColor: Colors.transparent,
            indicatorColor: Colors.white,
            backgroundColor: Colors.amber,
          ),
          customStyleBuilder: (context, local, global) => ToggleStyle(
              backgroundGradient: LinearGradient(
            colors: [Colors.green, Colors.red],
            stops: [
              global.position - (1 - 2 * max(0, global.position - 0.5)) * 0.5,
              global.position + max(0, 2 * (global.position - 0.5)) * 0.5,
            ],
          )),
          borderWidth: 6.0,
          height: 60.0,
          loadingIconBuilder: (context, global) => CupertinoActivityIndicator(
              color: Color.lerp(Colors.red, Colors.green, global.position)),
          onChanged: (b) {
            setState(() => positive = b);
            return Future<dynamic>.delayed(const Duration(seconds: 2));
          },
          iconBuilder: (value) => value
              ? const Icon(Icons.power_outlined,
                  color: Colors.green, size: 32.0)
              : const Icon(Icons.power_settings_new_rounded,
                  color: Colors.red, size: 32.0),
          textBuilder: (value) => Center(
              child: Text(
            value ? 'On' : 'Off',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w600),
          )),
        ),
      ],
    );
  }
}
