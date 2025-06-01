import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late FormGroup form;

  @override
  void initState() {
    form = FormGroup({
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
    });

    super.initState();
  }

  Future<bool> checkSupabaseEmailExists(String email) async {
    final response = await Supabase.instance.client
        .from('profile')
        .select('email')
        .eq('email', email);
    return response.isNotEmpty;
  }

  Future<bool> checkAuth0EmailExists(String email) async {
    final response = await Supabase.instance.client
        .from('account')
        .select('email')
        .eq('email', email)
        .eq('source', 'auth0');
    return response.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: Center(
        child: ReactiveForm(
          formGroup: form,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: const InputDecoration(label: Text('Email *')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: FilledButton(
                    onPressed: () async {
                      form.markAllAsTouched();

                      if (form.valid) {
                        try {
                          EasyLoading.show(status: 'Checking...');
                          final emailVal = form.value['email'] as String;
                          final isSupabaseExisted =
                              await checkSupabaseEmailExists(emailVal);

                          if (isSupabaseExisted) {
                            if (context.mounted) {
                              SupabaseLoginRoute(email: emailVal).push(context);
                            }
                            return;
                          }

                          final isAuth0Existed =
                              await checkAuth0EmailExists(emailVal);
                          if (isAuth0Existed) {
                            if (context.mounted) {
                              Auth0LoginRoute(email: emailVal).push(context);
                              return;
                            }
                          }

                          if (context.mounted) {
                            const AzureB2CLoginRoute().push(context);
                          }
                        } catch (e) {
                          EasyLoading.showError(e.toString());
                        } finally {
                          EasyLoading.dismiss();
                        }
                      }
                    },
                    child: const Text('CHECK EMAIL'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      const SupabaseSignUpRoute().push(context);
                    },
                    child: const Text('SIGN UP'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
