import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/add_task_bottom_sheet.dart';
import 'package:todo_app/screens/settings_tab/settings_tab.dart';
import 'package:todo_app/screens/task_list_tab/task_list_tab.dart';

import '../styling/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? AppLocalizations.of(context)!.todo_app
              : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: themeProvider.isDark()
                  ? AppColors.blackColor
                  : AppColors.whiteColor),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: width * 0.06,
              ),
              label: AppLocalizations.of(context)!.task_list,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: width * 0.06,
              ),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: width * 0.07,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TaskListTab() : const SettingsTab(),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
