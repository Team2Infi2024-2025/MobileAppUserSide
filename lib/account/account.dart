import 'package:flutter/material.dart';

/*
  Page with account information

  To-Do
  - [] pull account info from supabase
  - [] page where user management info is displayed (Mann)
  - [] need user management completed anyways
 */

/// also include health history?

class Account extends StatelessWidget {

  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 45.0), // Add padding to the top
        child: Text('Sample Text')

    );
  }
}
