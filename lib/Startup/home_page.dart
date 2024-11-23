import 'package:flutter/material.dart';

import '../Transactions/transactions.dart';


GlobalKey homeKey = GlobalKey();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: homeKey);
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int pageIndex = 3;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: pageIndex == 0
            ? NeverScrollableScrollPhysics()
            : ClampingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          // need to input pages here (the classes)
          Transactions()
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: _buildTopBar(context),
      extendBody: true,
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  // Builds the top bar with settings and account icons
  Stack _buildTopBar(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 14,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.account_circle,
                color: Theme.of(context).colorScheme.onSurface, size: 32),
            onPressed: () {
              // Need to readd when profiles page is added
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Profiles()));
            },
          ),
        ),
      ],
    );
  }

  // Builds the bottom navigation bar
  Container _buildNavBar(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 0, iconColor),
          _buildNavItem(Icons.location_on_sharp, 1, iconColor),
          _buildNavItem(Icons.search, 2, iconColor),
          _buildNavItem(Icons.message_outlined, 3, iconColor),
          _buildNavItem(Icons.account_circle_sharp, 4, iconColor),
        ],
      ),
    );
  }

  // Builds individual navigation bar item
  IconButton _buildNavItem(IconData icon, int index, Color iconColor) {
    return IconButton(
      icon: Icon(
        icon,
        color: iconColor,
        size: pageIndex == index ? 35 : 27,
      ),
      onPressed: () {
        setState(() {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        });
      },
    );
  }
}


class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: Center(child: Text('Account Page')),
    );
  }
}
