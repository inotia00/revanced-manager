import 'package:flutter/material.dart';
import 'package:revanced_manager/gen/strings.g.dart';
import 'package:revanced_manager/ui/views/settings/settings_viewmodel.dart';
import 'package:revanced_manager/ui/widgets/shared/haptics/haptic_switch_list_tile.dart';

class SPreReleases extends StatefulWidget {
  const SPreReleases({super.key});

  @override
  State<SPreReleases> createState() => _SPreReleasesState();
}

final _settingsViewModel = SettingsViewModel();

class _SPreReleasesState extends State<SPreReleases> {
  @override
  Widget build(BuildContext context) {
    return HapticSwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: Text(
        t.settingsView.preReleasesLabel,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(t.settingsView.preReleasesHint),
      value: _settingsViewModel.isPreReleasesEnabled(),
      onChanged: (value) async {
        await _settingsViewModel.showPrelereasesDialog(context, value);
        setState(() {});
      },
    );
  }
}