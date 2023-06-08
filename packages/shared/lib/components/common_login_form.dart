import 'package:flutter/material.dart';

class CommonLoginForm extends StatefulWidget {
  final bool isLoading;
  final Function(String, String)? onSubmit;
  final String? errorMessage;
  const CommonLoginForm({
    super.key,
    this.isLoading = false,
    this.onSubmit,
    this.errorMessage,
  });

  @override
  State<CommonLoginForm> createState() => _CommonLoginFormState();
}

class _CommonLoginFormState extends State<CommonLoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.errorMessage!),
        ),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Log in",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward_rounded),
              onPressed: widget.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Loggin in...'),
                          ),
                        );
                        if (widget.onSubmit != null) {
                          widget.onSubmit!(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      }
                    },
              label: const Text("Go"),
            ),
          ],
        ),
      ),
    );
  }
}
