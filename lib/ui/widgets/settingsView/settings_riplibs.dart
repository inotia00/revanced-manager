import 'package:flutter/material.dart';
import 'package:flutter_i18n/widgets/I18nText.dart';
import 'package:revanced_manager/ui/views/settings/settings_viewmodel.dart';

class SRipLibs extends StatefulWidget {
  const SRipLibs({super.key});

  @override
  State<SRipLibs> createState() => _SRipLibsState();
}

final _settingsViewModel = SettingsViewModel();

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
      },
    );
  }
}
