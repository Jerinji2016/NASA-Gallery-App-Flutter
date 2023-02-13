import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nasa_gallery/provider/data_provider.dart';

class ThemeChangerIcon extends StatefulWidget {
  const ThemeChangerIcon({Key? key}) : super(key: key);

  @override
  State<ThemeChangerIcon> createState() => _ThemeChangerIconState();
}

class _ThemeChangerIconState extends State<ThemeChangerIcon> {
  @override
  Widget build(BuildContext context) {
    AppDataProvider provider = AppDataProvider.of(context, listen: true);
    ThemeMode mode = provider.theme;

    IconData icon;
    Color iconColor;

    switch (mode) {
      case ThemeMode.system:
        icon = Icons.cloud_outlined;
        var brightness = SchedulerBinding.instance.window.platformBrightness;
        iconColor = brightness == Brightness.dark ? Colors.white : Colors.black;
        break;
      case ThemeMode.light:
        icon = Icons.light_mode_outlined;
        iconColor = Colors.black;
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode_outlined;
        iconColor = Colors.white;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: provider.toggleTheme,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
