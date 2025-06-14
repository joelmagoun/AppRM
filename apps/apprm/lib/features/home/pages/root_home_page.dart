import 'package:flutter/material.dart';

import '../../../bootstrap/powersync.dart';
import '../../application/pages/application_listing_page.dart';
import 'home_page.dart';

class RootHomePage extends StatefulWidget {
  const RootHomePage({super.key});

  @override
  State<RootHomePage> createState() => _RootHomePageState();
}

class _RootHomePageState extends State<RootHomePage> {
  late Future<bool> _checkAdmin;

  @override
  void initState() {
    super.initState();
    _checkAdmin = isAdminUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAdmin,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final admin = snapshot.data ?? false;
        return admin ? const HomePage() : const ApplicationListingPage();
      },
    );
  }
}
