import 'package:flutter/material.dart';

void main() {
  // The main() function is the entry point of every Dart application.
  //
  // In Flutter, runApp() is used to attach the root widget to the screen.
  // Here, SignupFormApp becomes the root of the widget tree.
  runApp(const SignupFormApp());
}

/// SignupFormApp is the root widget of this lab.
///
/// This widget is responsible for:
/// 1. Creating the MaterialApp.
/// 2. Setting the app title.
/// 3. Defining the global theme.
/// 4. Opening SignupScreen as the first screen.
///
/// This widget is StatelessWidget because it does not store or update any state.
class SignupFormApp extends StatelessWidget {
  const SignupFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Signup Form',

      // Removes the debug banner in the top-right corner of the app.
      debugShowCheckedModeBanner: false,

      // ThemeData defines the global look and feel of the app.
      // useMaterial3 enables modern Material Design components.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      // SignupScreen is the first screen displayed when the app starts.
      home: const SignupScreen(),
    );
  }
}

/// SignupScreen contains the full signup form.
///
/// This screen must be StatefulWidget because many values can change:
/// - User input values
/// - Password visibility
/// - Confirm password visibility
/// - Terms checkbox
/// - Loading state during async email check
/// - Password strength text
///
/// A signup form is a good example of UI that needs state.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  /// GlobalKey<FormState> gives access to the Form's current state.
  ///
  /// We use it to:
  /// - validate all fields at once
  /// - save all fields after validation succeeds
  /// - reset the form if needed
  ///
  /// Important methods:
  /// - _formKey.currentState!.validate()
  /// - _formKey.currentState!.save()
  /// - _formKey.currentState!.reset()
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// FocusNodes are used to control keyboard focus manually.
  ///
  /// In this lab, they allow the user to move smoothly:
  /// Full Name -> Email -> Password -> Confirm Password
  ///
  /// This improves mobile UX because the keyboard "Next" button works properly.
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  /// These variables store form values.
  ///
  /// They are updated using onChanged and/or onSaved.
  /// Storing password in state is needed because confirm password validator
  /// must compare its value with the original password.
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  /// Controls whether the password field is hidden or visible.
  ///
  /// true means the password is hidden.
  /// false means the password is visible.
  bool _obscurePassword = true;

  /// Controls whether the confirm password field is hidden or visible.
  bool _obscureConfirmPassword = true;

  /// Stores whether the user accepted Terms & Conditions.
  ///
  /// This is an optional enhancement from the lab.
  /// The form should not submit if this value is false.
  bool _acceptedTerms = false;

  /// Indicates whether the app is currently checking email availability.
  ///
  /// When true:
  /// - Submit button is disabled
  /// - A loading spinner is displayed inside the button
  ///
  /// This prevents users from submitting the form multiple times.
  bool _isCheckingEmail = false;

  /// Calculates password strength text based on the current password.
  ///
  /// This is a simple password strength indicator:
  /// - Empty: no strength
  /// - Weak: less than 8 characters or no digit
  /// - Medium: at least 8 characters and has digit
  /// - Strong: at least 10 characters, has digit, has uppercase letter
  ///
  /// This is an optional enhancement from the lab.
  String get _passwordStrengthText {
    if (_password.isEmpty) return '';

    final hasDigit = RegExp(r'[0-9]').hasMatch(_password);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(_password);

    if (_password.length >= 10 && hasDigit && hasUppercase) {
      return 'Strong';
    }

    if (_password.length >= 8 && hasDigit) {
      return 'Medium';
    }

    return 'Weak';
  }

  /// Returns a color for the password strength label.
  ///
  /// Red = Weak
  /// Orange = Medium
  /// Green = Strong
  Color get _passwordStrengthColor {
    switch (_passwordStrengthText) {
      case 'Strong':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Weak':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  /// Validates the full name field.
  ///
  /// validator must return:
  /// - null if the input is valid
  /// - a String error message if the input is invalid
  String? _validateFullName(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Full name is required';
    }

    if (text.length < 2) {
      return 'Full name must be at least 2 characters';
    }

    return null;
  }

  /// Validates the email field.
  ///
  /// Lab requirement:
  /// - Email is required.
  /// - Email must contain at least "@" and ".".
  ///
  /// This is a simple email validation suitable for beginner-level labs.
  /// In production apps, a stronger regex or backend validation may be used.
  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Email is required';
    }

    if (!text.contains('@') || !text.contains('.')) {
      return 'Enter a valid email';
    }

    return null;
  }

  /// Validates the password field.
  ///
  /// Lab requirement:
  /// - Password is required.
  /// - Password must be at least 8 characters.
  /// - Password must contain at least one digit.
  String? _validatePassword(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Password is required';
    }

    if (text.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return 'Password must contain at least 1 digit';
    }

    return null;
  }

  /// Validates the confirm password field.
  ///
  /// Lab requirement:
  /// - Confirm password is required.
  /// - Confirm password must match password.
  ///
  /// We compare confirm password with _password stored in state.
  String? _validateConfirmPassword(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Please confirm your password';
    }

    if (text != _password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Simulates async email availability check.
  ///
  /// Lab optional requirement:
  /// - Use Future.delayed to simulate API check.
  /// - If email starts with "taken", treat it as already used.
  ///
  /// Example:
  /// taken@example.com -> unavailable
  /// user@example.com -> available
  Future<bool> _isEmailAvailable(String email) async {
    // Simulate network delay.
    // In a real app, this would be an HTTP request to the backend.
    await Future.delayed(const Duration(seconds: 2));

    // Fake rule for this lab:
    // emails starting with "taken" are considered already registered.
    return !email.toLowerCase().startsWith('taken');
  }

  /// Handles form submission.
  ///
  /// Submit flow:
  /// 1. Hide keyboard.
  /// 2. Validate all fields using FormState.validate().
  /// 3. Check Terms & Conditions.
  /// 4. Save form values.
  /// 5. Run async email check.
  /// 6. Show error if email is taken.
  /// 7. Show success message if everything is valid.
  Future<void> _submit() async {
    // Hide keyboard before validating/submitting.
    FocusScope.of(context).unfocus();

    // validate() runs all validator functions inside the Form.
    //
    // If any validator returns an error string, validate() returns false.
    // If all validators return null, validate() returns true.
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      // Stop the submit flow if the form has invalid fields.
      return;
    }

    // Terms checkbox validation.
    //
    // This is not a TextFormField, so it does not use validator directly.
    // We check it manually before submitting.
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Conditions'),
        ),
      );
      return;
    }

    // save() calls onSaved() of every TextFormField inside the Form.
    _formKey.currentState!.save();

    setState(() {
      _isCheckingEmail = true;
    });

    final emailAvailable = await _isEmailAvailable(_email);

    // Always check mounted after an async operation before using context
    // or calling setState, because the widget may have been removed.
    if (!mounted) return;

    setState(() {
      _isCheckingEmail = false;
    });

    if (!emailAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is already taken'),
        ),
      );
      return;
    }

    // If all checks pass, show success feedback.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signup successful. Welcome, $_fullName!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector detects taps outside the input fields.
      //
      // When the user taps outside the form, we call unfocus()
      // to dismiss the mobile keyboard.
      //
      // This is required by the lab's focus and keyboard management section.
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),

        // SafeArea prevents content from being hidden behind:
        // - status bar
        // - notch
        // - camera cutout
        body: SafeArea(
          // ListView is used to avoid overflow when the keyboard opens.
          //
          // If we used a normal Column and the keyboard covered the screen,
          // Flutter could show a bottom overflow error.
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),

              const SizedBox(height: 24),

              Form(
                key: _formKey,

                // autovalidateMode.onUserInteraction means:
                // validation messages appear after the user starts interacting
                // with the fields.
                //
                // This gives faster feedback without showing red errors
                // immediately when the screen first opens.
                autovalidateMode: AutovalidateMode.onUserInteraction,

                child: Column(
                  children: [
                    _buildFullNameField(),

                    const SizedBox(height: 16),

                    _buildEmailField(),

                    const SizedBox(height: 16),

                    _buildPasswordField(),

                    const SizedBox(height: 8),

                    _buildPasswordStrengthIndicator(),

                    const SizedBox(height: 16),

                    _buildConfirmPasswordField(),

                    const SizedBox(height: 16),

                    _buildTermsCheckbox(),

                    const SizedBox(height: 24),

                    _buildSubmitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top header of the signup screen.
  ///
  /// This section is only visual, but it improves the user experience
  /// by explaining what the form is for.
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.person_add_alt_1,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),

        const SizedBox(height: 12),

        Text(
          'Create your account',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Please fill in the form below. Fields will be validated before signup.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  /// Builds the full name TextFormField.
  Widget _buildFullNameField() {
    return TextFormField(
      focusNode: _nameFocusNode,

      decoration: const InputDecoration(
        labelText: 'Full name',
        hintText: 'Enter your full name',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),

      // The keyboard action button will show "Next".
      textInputAction: TextInputAction.next,

      // When the user presses Next, move focus to the email field.
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },

      validator: _validateFullName,

      // onSaved is called when _formKey.currentState!.save() runs.
      onSaved: (value) {
        _fullName = value!.trim();
      },
    );
  }

  /// Builds the email TextFormField.
  Widget _buildEmailField() {
    return TextFormField(
      focusNode: _emailFocusNode,

      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'example@email.com',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),

      // Email keyboard shows email-friendly keys on mobile devices.
      keyboardType: TextInputType.emailAddress,

      textInputAction: TextInputAction.next,

      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },

      validator: _validateEmail,

      onSaved: (value) {
        _email = value!.trim();
      },

      // Keep the latest email value in state.
      // This is useful for async checking later.
      onChanged: (value) {
        _email = value.trim();
      },
    );
  }

  /// Builds the password TextFormField.
  Widget _buildPasswordField() {
    return TextFormField(
      focusNode: _passwordFocusNode,

      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'At least 8 characters and 1 digit',
        prefixIcon: const Icon(Icons.lock),
        border: const OutlineInputBorder(),

        // Suffix icon allows the user to show/hide the password.
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),

      // obscureText hides password characters.
      obscureText: _obscurePassword,

      textInputAction: TextInputAction.next,

      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },

      validator: _validatePassword,

      onChanged: (value) {
        // Store password in state so confirm password validator
        // and password strength indicator can use it.
        setState(() {
          _password = value;
        });
      },

      onSaved: (value) {
        _password = value!;
      },
    );
  }

  /// Builds a simple password strength indicator.
  ///
  /// This is optional but improves UX because users can immediately see
  /// whether their password is weak, medium, or strong.
  Widget _buildPasswordStrengthIndicator() {
    if (_passwordStrengthText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Icon(
          Icons.security,
          size: 18,
        ),

        const SizedBox(width: 8),

        Text(
          'Password strength: ',
          style: Theme.of(context).textTheme.bodySmall,
        ),

        Text(
          _passwordStrengthText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _passwordStrengthColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Builds the confirm password TextFormField.
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      focusNode: _confirmPasswordFocusNode,

      decoration: InputDecoration(
        labelText: 'Confirm password',
        hintText: 'Re-enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        border: const OutlineInputBorder(),

        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),

      obscureText: _obscureConfirmPassword,

      // Last field uses "Done" instead of "Next".
      textInputAction: TextInputAction.done,

      // When user presses Done, submit the form.
      onFieldSubmitted: (_) {
        _submit();
      },

      validator: _validateConfirmPassword,

      onChanged: (value) {
        _confirmPassword = value;
      },

      onSaved: (value) {
        _confirmPassword = value!;
      },
    );
  }

  /// Builds Terms & Conditions checkbox.
  ///
  /// This is an optional enhancement from the lab.
  /// It demonstrates how to validate a non-text input before submission.
  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,

      title: const Text('I accept the Terms & Conditions'),

      value: _acceptedTerms,

      onChanged: (value) {
        setState(() {
          _acceptedTerms = value ?? false;
        });
      },

      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  /// Builds the submit button.
  ///
  /// When _isCheckingEmail is true:
  /// - button is disabled
  /// - loading spinner is displayed
  ///
  /// This prevents double submission while async validation is running.
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: _isCheckingEmail ? null : _submit,

        child: _isCheckingEmail
            ? const SizedBox(
          width: 20,
          height: 20,

          // Small loading spinner shown inside the button.
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : const Text('Create Account'),
      ),
    );
  }

  @override
  void dispose() {
    // FocusNodes must be disposed when the screen is removed.
    //
    // This prevents memory leaks.
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }
}