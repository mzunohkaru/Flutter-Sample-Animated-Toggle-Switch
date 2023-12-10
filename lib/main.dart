import 'dart:math';

import 'package:anim_toggle/widgets/basic.dart';
import 'package:anim_toggle/widgets/loding.dart';
import 'package:anim_toggle/widgets/switchs/switch_packages.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedToggleSwitch Demo',
      theme:
          ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value = 0;
  int? nullableValue;
  bool positive = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: DefaultTextStyle(
        style: theme.textTheme.titleLarge!,
        textAlign: TextAlign.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual:',
                ),
              ),
              const BasicAnimatedToggleSwitch(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual with loading animation:',
                ),
              ),
              const LoadingAnimatedToggleSwitch(),
              const SwitchPackagesAnimatedToggleSwitch(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Standard AnimatedToggleSwitch.rolling:',
                ),
              ),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                indicatorIconScale: sqrt2,
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() => value = i);
                  return Future<dynamic>.delayed(const Duration(seconds: 3));
                },
                iconBuilder: rollingIconBuilder,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Switch with unselected value:',
                ),
              ),
              AnimatedToggleSwitch<int?>.rolling(
                allowUnlistedValues: true,
                styleAnimationType: AnimationType.onHover,
                current: nullableValue,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
                customStyleBuilder: (context, local, global) {
                  final color = local.isValueListed
                      ? null
                      : Theme.of(context).colorScheme.error;
                  return ToggleStyle(borderColor: color, indicatorColor: color);
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Customized AnimatedToggleSwitch.rolling:',
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rolling(
                active: false,
                current: value,
                values: const [0, 1, 2, 3],
                indicatorIconScale: sqrt2,
                onChanged: (i) {
                  setState(() {
                    value = i;
                    loading = true;
                  });
                  return Future<Object?>.delayed(const Duration(seconds: 3))
                      .then((_) => setState(() => loading = false));
                },
                iconBuilder: rollingIconBuilder,
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  indicatorBoxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              IconTheme.merge(
                data: const IconThemeData(color: Colors.white),
                child: AnimatedToggleSwitch<int>.rolling(
                  current: value,
                  values: const [0, 1, 2, 3],
                  onChanged: (i) => setState(() => value = i),
                  style: const ToggleStyle(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      )
                    ],
                  ),
                  indicatorIconScale: sqrt2,
                  iconBuilder: coloredRollingIconBuilder,
                  borderWidth: 3.0,
                  styleAnimationType: AnimationType.onHover,
                  styleBuilder: (value) => ToggleStyle(
                    backgroundColor: colorBuilder(value),
                    borderRadius: BorderRadius.circular(value * 10.0),
                    indicatorBorderRadius: BorderRadius.circular(value * 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                separatorBuilder: (index) => const VerticalDivider(),
                borderWidth: 4.5,
                style: ToggleStyle(
                  indicatorColor: Colors.white,
                  backgroundColor: Colors.amber,
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                styleBuilder: (i) => const ToggleStyle(
                    // indicatorGradient: LinearGradient(
                    //     colors: [colorBuilder(i), colorBuilder((i + 1) % 4)]),
                    ),
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int?>.rolling(
                current: nullableValue,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onTap: (info) {
                  if (nullableValue == info.tapped?.value) {
                    setState(() => nullableValue = null);
                  }
                },
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
                borderWidth: 4.5,
                style: const ToggleStyle(
                  indicatorColor: Colors.white,
                  backgroundGradient:
                      LinearGradient(colors: [Colors.red, Colors.blue]),
                  borderColor: Colors.transparent,
                ),
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with some custom settings:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                styleAnimationType: AnimationType.onHover,
                iconBuilder: (value) => Icon(
                    value.isEven ? Icons.cancel : Icons.access_time_rounded),
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                ),
                borderWidth: 0.0,
                styleBuilder: (i) {
                  final color = colorBuilder(i);
                  return ToggleStyle(
                    backgroundColor: color.withOpacity(0.3),
                    indicatorColor: color,
                  );
                },
                onChanged: (i) {
                  setState(() => value = i);
                  return Future<dynamic>.delayed(const Duration(seconds: 3));
                },
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.size(
                textDirection: TextDirection.rtl,
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                iconBuilder: iconBuilder,
                borderWidth: 4.0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                styleBuilder: (i) =>
                    ToggleStyle(indicatorColor: colorBuilder(i)),
                onChanged: (i) => setState(() => value = i),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.size(
                current: positive,
                values: const [false, true],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                customIconBuilder: (context, local, global) => Text(
                    local.value ? 'RAM' : 'CPU',
                    style: TextStyle(
                        color: Color.lerp(
                            Colors.black, Colors.white, local.animationValue))),
                borderWidth: 4.0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  indicatorColor: Colors.teal,
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                selectedIconScale: 1.0,
                onChanged: (b) => setState(() => positive = b),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with a more custom icon and TextDirection.rtl:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                textDirection: TextDirection.rtl,
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                customIconBuilder: (context, local, global) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${local.value}'),
                      alternativeIconBuilder(context, local, global),
                    ],
                  );
                },
                style: const ToggleStyle(borderColor: Colors.transparent),
                styleBuilder: (i) => ToggleStyle(
                    indicatorColor:
                        i.isEven == true ? Colors.amber : Colors.red),
                onChanged: (i) => setState(() => value = i),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with custom rotating animation:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 1.0,
                selectedIconScale: 1.0,
                indicatorSize: const Size.fromWidth(25),
                foregroundIndicatorIconBuilder: (context, global) {
                  double pos = global.position;
                  double transitionValue = pos - pos.floorToDouble();
                  return Transform.rotate(
                      angle: 2.0 * pi * transitionValue,
                      child: Stack(children: [
                        Opacity(
                            opacity: 1 - transitionValue,
                            child: iconBuilder(pos.floor())),
                        Opacity(
                            opacity: transitionValue,
                            child: iconBuilder(pos.ceil()))
                      ]));
                },
                iconBuilder: iconBuilder,
                style: const ToggleStyle(
                  borderColor: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  indicatorBorderRadius: BorderRadius.zero,
                ),
                styleBuilder: (i) => ToggleStyle(
                    indicatorColor:
                        i.isEven == true ? Colors.green : Colors.tealAccent),
                onChanged: (i) => setState(() => value = i),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.rollingByHeight with custom indicatorSize and borderRadius:',
                ),
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: const Size.fromWidth(2),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: const Size.square(1.5),
                style: ToggleStyle(borderRadius: BorderRadius.circular(75.0)),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Color colorBuilder(int value) => switch (value) {
        0 => Colors.blueAccent,
        1 => Colors.green,
        2 => Colors.orangeAccent,
        _ => Colors.red,
      };

  Widget coloredRollingIconBuilder(int value, bool foreground) {
    final color = foreground ? colorBuilder(value) : null;
    return Icon(
      iconDataByValue(value),
      color: color,
    );
  }

  Widget iconBuilder(int value) {
    return rollingIconBuilder(value, false);
  }

  Widget rollingIconBuilder(int? value, bool foreground) {
    return Icon(iconDataByValue(value));
  }

  IconData iconDataByValue(int? value) => switch (value) {
        0 => Icons.access_time_rounded,
        1 => Icons.check_circle_outline_rounded,
        2 => Icons.power_settings_new_rounded,
        _ => Icons.lightbulb_outline_rounded,
      };

  Widget sizeIconBuilder(BuildContext context,
      AnimatedToggleProperties<int> local, GlobalToggleProperties<int> global) {
    return iconBuilder(local.value);
  }

  Widget alternativeIconBuilder(BuildContext context,
      AnimatedToggleProperties<int> local, GlobalToggleProperties<int> global) {
    IconData data = Icons.access_time_rounded;
    switch (local.value) {
      case 0:
        data = Icons.ac_unit_outlined;
        break;
      case 1:
        data = Icons.account_circle_outlined;
        break;
      case 2:
        data = Icons.assistant_navigation;
        break;
      case 3:
        data = Icons.arrow_drop_down_circle_outlined;
        break;
    }
    return Icon(data);
  }
}
