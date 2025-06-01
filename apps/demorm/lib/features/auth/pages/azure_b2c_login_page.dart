import 'package:aad_b2c_webview/aad_b2c_webview.dart';
import 'package:apprm/configs/azure_b2c.dart';
import 'package:apprm/router.dart';
import 'package:flutter/material.dart';

class AzureB2CLoginPage extends StatefulWidget {
  const AzureB2CLoginPage({super.key, this.email});

  final String? email;

  @override
  State<AzureB2CLoginPage> createState() => _AzureB2CLoginPageState();
}

class _AzureB2CLoginPageState extends State<AzureB2CLoginPage> {
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
            AADLoginButton(
              userFlowUrl: AzureB2CConfig.userAuthFlow,
              clientId: AzureB2CConfig.clientID,
              userFlowName: AzureB2CConfig.userFlowName,
              redirectUrl: AzureB2CConfig.redirectURL,
              scopes: AzureB2CConfig.scopes,
              context: context,
              onAnyTokenRetrieved: (Token anyToken) {
                debugPrint('AAAAA ${anyToken.type} ${anyToken.value}');
              },
              onIDToken: (Token token) {
                jwtToken = token.value;
              },
              onAccessToken: (Token token) {},
              onRefreshToken: (Token token) {
                refreshToken = token.value;
              },
              onRedirect: (context) {
                debugPrint('[AUTH END]');
                Navigator.of(context).pop();
                HomeRoute().replace(context);
              },
              optionalParameters: [
                if (widget.email != null)
                  OptionalParam(key: 'login_hint', value: widget.email!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
