import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    ThemeMode themeMode,
    Color? primaryColor,
  )
  builder;

  final String themeModeSettingKey;
  final String primaryColorSettingKey;

  const ThemeBuilder({
    required this.builder,
    this.themeModeSettingKey = 'theme_mode',
    this.primaryColorSettingKey = 'primary_color',
    super.key,
  });

  @override
  State<ThemeBuilder> createState() => ThemeController();
}

class ThemeController extends State<ThemeBuilder> {
  SharedPreferences? _sharedPreferences;
  ThemeMode? _themeMode;
  Color? _primaryColor;

  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;
  Color? get primaryColor => _primaryColor;

  static ThemeController of(BuildContext context) =>
      Provider.of<ThemeController>(context, listen: false);

  void _loadData(_) async {
    final preferences = _sharedPreferences ??=
        await SharedPreferences.getInstance();
    final rawThemeMode = preferences.getString(widget.themeModeSettingKey);
    final rawPrimaryColor = preferences.getInt(widget.primaryColorSettingKey);

    setState(() {
      _themeMode = ThemeMode.values.singleWhereOrNull(
        (value) => value.name == rawThemeMode,
      );
      _primaryColor = rawPrimaryColor == null ? null : Color(rawPrimaryColor);
    });
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    final preferences =
        _sharedPreferences ?? await SharedPreferences.getInstance();

    await preferences.setString(widget.themeModeSettingKey, newThemeMode.name);

    setState(() {
      _themeMode = newThemeMode;
    });
  }

  Future<void> setPrimaryColor(Color? newPrimaryColor) async {
    final preferences = _sharedPreferences ??=
        await SharedPreferences.getInstance();
    if (newPrimaryColor == null) {
      await preferences.remove(widget.primaryColorSettingKey);
    } else {
      await preferences.setInt(
        widget.primaryColorSettingKey,
        newPrimaryColor.toARGB32(),
      );
    }
    setState(() {
      _primaryColor = newPrimaryColor;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_loadData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => this,
      child: DynamicColorBuilder(
        builder: (light, _) =>
            widget.builder(context, themeMode, primaryColor ?? light?.primary),
      ),
    );
  }
}
