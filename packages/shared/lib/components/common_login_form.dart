import 'package:flutter/material.dart';
import 'package:shared/constants/colors.dart';

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

  bool _showPassword = false;

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

  void _login() {
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
              enabled: !widget.isLoading,
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
              onFieldSubmitted: (val) => _login,
              onSaved: (val) => _login,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              enabled: !widget.isLoading,
              controller: passwordController,
              obscureText: !_showPassword,
              decoration:  InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                }, icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility)),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (val) => _login,
              onFieldSubmitted: (val) => _login,
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (widget.errorMessage != null)
              Text(
                widget.errorMessage!,
                style: const TextStyle(color: AppColors.error),
              ),
            const SizedBox(
              height: 16.0,
            ),
            !widget.isLoading
                ? ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: _login,
                    label: const Text("Go"),
                  )
                : const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator.adaptive(),
                  )
          ],
        ),
      ),
    );
  }
}
