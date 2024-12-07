import 'package:flutter/material.dart';
import 'package:revanced_manager/gen/strings.g.dart';
import 'package:revanced_manager/ui/views/settings/settings_viewmodel.dart';
import 'package:revanced_manager/ui/widgets/shared/haptics/haptic_switch_list_tile.dart';

class SRipLibs extends StatefulWidget {
  const SRipLibs({super.key});

  @override
  State<SRipLibs> createState() => _SRipLibsState();
}

final _settingsViewModel = SettingsViewModel();

class _SRipLibsState extends State<SRipLibs> {
  @override
  Widget build(BuildContext context) {
    return HapticSwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: Text(
        t.settingsView.ripLibsLabel,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(t.settingsView.ripLibsHint),
      value: _settingsViewModel.isRipLibsEnabled(),
      onChanged: (value) {
        setState(() {
          _settingsViewModel.showRipLibs(value);
        });
      },
    );
  }
}