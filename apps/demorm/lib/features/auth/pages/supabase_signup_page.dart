import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSignUpPage extends StatefulWidget {
  const SupabaseSignUpPage({super.key, this.email});

  final String? email;

  @override
  State<SupabaseSignUpPage> createState() => _SupabaseSignUpPageState();
}

class _SupabaseSignUpPageState extends State<SupabaseSignUpPage> {
  late FormGroup form;

  @override
  void initState() {
    form = FormGroup({
      'email': FormControl<String>(
        value: widget.email,
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupabaseSignUp Page'),
      ),
      body: Center(
        child: ReactiveForm(
          formGroup: form,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: const InputDecoration(
                    label: Text('Email *'),
                  ),
                ),
                ReactiveTextField(
                  formControlName: 'password',
                  decoration: const InputDecoration(
                    label: Text('Password *'),
                  ),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        form.markAllAsTouched();
                        if (form.valid) {
                          try {
                            EasyLoading.show(
                              status: 'Creating...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            final formValues = form.value;
                            await Supabase.instance.client.auth.signUp(
                              email: formValues['email'] as String,
                              password: formValues['password'] as String,
                            );

                            EasyLoading.showSuccess(
                              'Please check confirmation in the mailbox',
                              maskType: EasyLoadingMaskType.black,
                            );
                            if (context.mounted) {
                              context.pop();
                            }
                          } catch (e) {
                            EasyLoading.showError(
                              e.toString(),
                              maskType: EasyLoadingMaskType.black,
                            );
                          } finally {
                            EasyLoading.dismiss();
                          }
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
