import 'package:flutter/material.dart';
import 'package:flutter_i18n/widgets/I18nText.dart';
import 'package:revanced_manager/ui/views/patcher/patcher_viewmodel.dart';
import 'package:revanced_manager/ui/views/patches_selector/patches_selector_viewmodel.dart';
import 'package:revanced_manager/ui/views/settings/settings_viewmodel.dart';

class SRipLibs extends StatefulWidget {
  const SRipLibs({super.key});

  @override
  State<SRipLibs> createState() => _SRipLibsState();
}

final _settingsViewModel = SettingsViewModel();
final _patchesSelectorViewModel = PatchesSelectorViewModel();
final _patcherViewModel = PatcherViewModel();

class _SRipLibsState extends State<SRipLibs> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: I18nText(
        'settingsView.ripLibsLabel',
        child: const Text(
          '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: I18nText('settingsView.ripLibsHint'),
      value: _settingsViewModel.isRipLibsEnabled(),
      onChanged: (value) {
        setState(() {
          _settingsViewModel.showRipLibs(value);
        });
        if (!value) {
          _patcherViewModel.selectedPatches
              .removeWhere((patch) => patch.compatiblePackages.isEmpty);
          _patchesSelectorViewModel.selectedPatches
              .removeWhere((patch) => patch.compatiblePackages.isEmpty);
        }
      },
    );
  }
}
