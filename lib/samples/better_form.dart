import 'package:flutter/material.dart';

class BetterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.toString())),

      // * tip 2: use FocusScope to respond to user taps and focus widget

      body: GestureDetector(
        child: _Body(),
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  // * tip 3: use autovalidate to remove errors immediately when user corrects them
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: Column(
          children: [
            _AppTextFormField(
              label: 'Username',
              controller: _userController,
            ),
            _AppTextFormField(
              label: 'Password',
              isLast: true,
              obscure: true,
              controller: _passwordController,
            ),
            Spacer(),
            FloatingActionButton.extended(
              label: Text('Submit'),
              onPressed: _validate,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validate() {
    String message;

    if (_formKey.currentState.validate()) {
      message = 'All good!';
    } else {
      setState(() => _autovalidate = true);
      message = 'Please fill the info!';
    }

    // * tip 4: give feedback with dialogs
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }
}

class _AppTextFormField extends StatelessWidget {
  const _AppTextFormField({
    Key key,
    @required this.label,
    this.controller,
    this.isLast = false,
    this.obscure = false,
  }) : super(key: key);

  final String label;
  final bool isLast;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      onChanged: (value) => controller.text = value,
      validator: (value) {
        return value.trim().isEmpty
            ? 'We need your ${label.toLowerCase()}'
            : null;
      },

      // * tip 5: set input actions

      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,

      // * tip 6: set a response

      onFieldSubmitted: (_) {
        if (!isLast) {
          FocusScope.of(context).nextFocus(
              /* here goes your widget's FocusNode */);
        }
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(20.0),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        labelText: label,
        errorStyle: TextStyle(color: Colors.red),
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
