import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer
import 'package:flutter/material.dart';
import 'homepage.dart'; // Assuming this is your homepage route
import '../main.dart'; // Assuming this is where currentUsername is defined
import 'login.dart'; // Import the LoginPage (we'll create this next)
import 'user.dart';
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  String? _sex;
  String? _age;
  String? _stage;
  final _schoolController = TextEditingController();

  final List<String> ages =
  List.generate(20, (index) => (index + 5).toString()); // Ages 5 to 24
  final List<String> stages = ['JHS 1', 'JHS 2', 'JHS 3'];
  final List<String> sexes = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    buildTextField(
                      label: 'Username',
                      controller: _usernameController,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextField(
                      label: 'First Name',
                      controller: _firstNameController,
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextField(
                      label: 'Surname',
                      controller: _surnameController,
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 16.0),
                    buildDropdown(
                      label: 'Sex',
                      items: sexes,
                      selectedValue: _sex,
                      onChanged: (val) => setState(() => _sex = val),
                      icon: Icons.wc_outlined,
                    ),
                    const SizedBox(height: 16.0),
                    buildDropdown(
                      label: 'Age',
                      items: ages,
                      selectedValue: _age,
                      onChanged: (val) => setState(() => _age = val),
                      icon: Icons.calendar_today_outlined,
                    ),
                    const SizedBox(height: 16.0),
                    buildDropdown(
                      label: 'Stage/Class',
                      items: stages,
                      selectedValue: _stage,
                      onChanged: (val) => setState(() => _stage = val),
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextField(
                      label: 'School',
                      controller: _schoolController,
                      icon: Icons.account_balance_outlined,
                    ),
                    const SizedBox(height: 30.0),

              ElevatedButton.icon(
              icon: const Icon(Icons.app_registration),
              label: const Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Create and set the currentUser object
                  currentUser = User(
                    username: _usernameController.text.trim(),
                    firstName: _firstNameController.text.trim(),
                    surname: _surnameController.text.trim(),
                    sex: _sex,
                    age: _age,
                    stage: _stage,
                    school: _schoolController.text.trim(),
                  );

                  // print('User Registered: ${currentUser?.username}');
                  // print('Full Name: ${currentUser?.fullName}');
                  // print('Age: ${currentUser?.age}, Sex: ${currentUser?.sex}');
                  // print('Stage: ${currentUser?.stage}, School: ${currentUser?.school}');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }
              },
            ),
                    const SizedBox(height: 20.0), // Space before the "Log In" text
                    Center( // Center the RichText
                      child: RichText(
                        text: TextSpan(
                          text: 'Already a student here? ',
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color ?? Colors.black87, // Default text color
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                color: theme.colorScheme.primary, // Use theme primary color
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to LoginPage
                                  // Using pushReplacement if you don't want users to go back to Register page from Login
                                  // Using push if you want them to be able to go back
                                  Navigator.push( // or Navigator.pushReplacement
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        fillColor: Colors.grey[50]?.withOpacity(0.7),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      validator: validator ?? (value) => value == null || value.isEmpty ? '$label is required' : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildDropdown({
    required String label,
    required List<String> items,
    required String? selectedValue,
    required Function(String?) onChanged,
    IconData? icon,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        fillColor: Colors.grey[50]?.withOpacity(0.7),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      value: selectedValue,
      items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? '$label is required' : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}