import 'package:fluchat/helpers.dart';
import 'package:fluchat/pages/calls_page.dart';
import 'package:fluchat/pages/contacts_page.dart';
import 'package:fluchat/pages/messages_page.dart';
import 'package:fluchat/pages/notification_page.dart';
import 'package:fluchat/theme.dart';
import 'package:fluchat/widgets/glowing_action_button.dart';
import 'package:fluchat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = [
    const MessagesPage(),
    const NotificationPage(),
    const CallsPage(),
    const ContactPage(),
  ];
  final pageTitle = [
    'Messages',
    'Notification',
    'Calls',
    'Contact',
  ];
  void onNavigationItemSelected(index) {
    title.value = pageTitle[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: const Color(0xFF1B1E1F),
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (context, String value, _) {
            return Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onItemSelected;
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                lable: 'Messages',
                index: 0,
                isSelected: selectedIndex == 0,
                onTap: handleItemSelected,
              ),
              NavigationBarItem(
                index: 1,
                lable: 'Notification',
                icon: CupertinoIcons.bell_solid,
                isSelected: selectedIndex == 1,
                onTap: handleItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {},
                ),
              ),
              NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: CupertinoIcons.phone_fill,
                isSelected: selectedIndex == 2,
                onTap: handleItemSelected,
              ),
              NavigationBarItem(
                index: 3,
                icon: CupertinoIcons.person_2_fill,
                lable: 'Contacsts',
                isSelected: selectedIndex == 3,
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final String lable;
  final IconData icon;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onTap;
  const NavigationBarItem(
      {Key? key,
      required this.lable,
      required this.icon,
      required this.index,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
