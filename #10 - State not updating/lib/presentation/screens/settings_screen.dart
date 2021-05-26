import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Settings"),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text(
                "App ${state.appNotifications.toString().toUpperCase()}, Email ${state.emailNotifications.toString().toUpperCase()}"),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications!,
                  onChanged: (newValue) {
                    context.read<SettingsCubit>().toggleAppNotifications(newValue);
                  },
                  title: Text("App Notifications"),
                ),
                SwitchListTile(
                  value: state.emailNotifications!,
                  onChanged: (newValue) {
                    context.read<SettingsCubit>().toggleEmailNotifications(newValue);
                  },
                  title: Text("Email Notifications"),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
