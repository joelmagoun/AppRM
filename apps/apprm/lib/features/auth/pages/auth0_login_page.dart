import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import '../../../configs/auth0.dart';

class Auth0LoginPage extends StatefulWidget {
  const Auth0LoginPage({super.key, this.email});

  final String? email;

  @override
  State<Auth0LoginPage> createState() => _Auth0LoginPageState();
}

class _Auth0LoginPageState extends State<Auth0LoginPage> {
  String? jwtToken;
  String? refreshToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FilledButton(
                onPressed: () async {
                  try {
                    const appAuth = FlutterAppAuth();

                    final result = await appAuth.authorizeAndExchangeCode(
                      AuthorizationTokenRequest(
                        Auth0Config.clientID,
                        Auth0Config.redirectURL,
                        discoveryUrl: Auth0Config.discoveryUrl,
                        scopes: Auth0Config.scopes,
                        loginHint: widget.email,
                        preferEphemeralSession: true,
                      ),
                    );

                    print(result.accessToken);

                    if (result.accessToken != null) {
                      if (context.mounted) {
                        HomeRoute().push(context);
                      }
                    }
                  } catch (error) {
                    print(error);
                  }
                },
                child: const Text('Login with Auth0'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
