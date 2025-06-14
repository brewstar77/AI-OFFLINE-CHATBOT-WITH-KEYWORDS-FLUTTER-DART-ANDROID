import 'package:flutter/material.dart';
import '../main.dart'; // To access and update currentUser, and User model if it's there
import 'user.dart'; // Assuming User class is here
import 'register.dart'; // To navigate to RegistrationPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditMode = false;

  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _surnameController;
  late TextEditingController _schoolController;

  // State variables for editable dropdowns
  String? _selectedSex;
  String? _selectedAge;
  String? _selectedStage;

  // Define lists for dropdowns
  // Consider making these 'final' if they don't change, or load them from a config/service
  final List<String> ages = List.generate(
      20, (index) => (index + 5).toString()); // Ages 5 to 24
  final List<String> stages = [
    'JHS 1',
    'JHS 2',
    'JHS 3',
    'SHS 1',
    'SHS 2',
    'SHS 3',
    'Tertiary'
  ]; // Example stages
  final List<String> sexes = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say'
  ]; // Example sexes

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    _initializeControllersAndSelections();
  }

  void _initializeControllersAndSelections() {
    _usernameController =
        TextEditingController(text: currentUser?.username ?? '');
    _firstNameController =
        TextEditingController(text: currentUser?.firstName ?? '');
    _surnameController =
        TextEditingController(text: currentUser?.surname ?? '');
    _schoolController = TextEditingController(text: currentUser?.school ?? '');

    // Initialize selected values for dropdowns from currentUser
    _selectedSex = currentUser?.sex;
    _selectedAge = currentUser?.age;
    _selectedStage = currentUser?.stage;

    // Safety check: Ensure initial selected values are valid if currentUser has them
    // If a value from currentUser is not in the list, it will default to null (dropdown shows hint)
    // or you could set a default like items.first if a selection is always required.
    if (_selectedSex != null && !sexes.contains(_selectedSex)) {
      _selectedSex = null;
    }
    if (_selectedAge != null && !ages.contains(_selectedAge)) {
      _selectedAge = null;
    }
    if (_selectedStage != null && !stages.contains(_selectedStage)) {
      _selectedStage = null;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        // If exiting edit mode without saving, reset changes
        _initializeControllersAndSelections();
      }
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) { // Validate all form fields
      if (currentUser != null) {
        currentUser = User(
          username: _usernameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          surname: _surnameController.text.trim(),
          school: _schoolController.text.trim(),
          sex: _selectedSex!,
          // Non-null assertion due to validator
          age: _selectedAge!,
          // Non-null assertion due to validator
          stage: _selectedStage!, // Non-null assertion due to validator
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
      setState(() {
        _isEditMode = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }

  void _handleLogout() {
    currentUser = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final User? user = currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Profile' : 'Student Profile'),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.done_outline : Icons.edit_outlined),
            onPressed: () {
              if (_isEditMode) {
                _saveChanges();
              } else {
                _toggleEditMode();
              }
            },
          ),
          if (_isEditMode)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleEditMode, // This will reset changes if not saved
            ),
        ],
      ),
      body: user == null
          ? const Center(
        child: Text('No user data found. Please register or log in.'),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.1),
                      child: Icon(
                        Icons.person_outline,
                        size: 60,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      !_isEditMode
                          ? (user.fullName.isNotEmpty ? user.fullName : user
                          .username ?? 'N/A')
                          : "Editing Profile...",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  if (!_isEditMode && user.fullName.isEmpty &&
                      user.username != null)
                    Center(
                      child: Text(
                        '@${user.username}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Divider(),

                  _buildEditableProfileField(
                    label: 'Username',
                    controller: _usernameController,
                    icon: Icons.account_circle_outlined,
                    isEditMode: _isEditMode,
                    originalValue: user.username,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return 'Username cannot be empty';
                      }
                      if (value
                          .trim()
                          .length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  _buildEditableProfileField(
                    label: 'First Name',
                    controller: _firstNameController,
                    icon: Icons.badge_outlined,
                    isEditMode: _isEditMode,
                    originalValue: user.firstName,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return 'First name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  _buildEditableProfileField(
                    label: 'Surname',
                    controller: _surnameController,
                    icon: Icons.badge_outlined,
                    isEditMode: _isEditMode,
                    originalValue: user.surname,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return 'Surname cannot be empty';
                      }
                      return null;
                    },
                  ),

                  _buildEditableDropdownField(
                    label: 'Sex',
                    icon: Icons.wc_outlined,
                    currentValue: _selectedSex,
                    items: sexes,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSex = newValue;
                      });
                    },
                    isEditMode: _isEditMode,
                    originalDisplayValue: user.sex,
                  ),
                  _buildEditableDropdownField(
                    label: 'Age',
                    icon: Icons.cake_outlined,
                    currentValue: _selectedAge,
                    items: ages,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAge = newValue;
                      });
                    },
                    isEditMode: _isEditMode,
                    originalDisplayValue: user.age,
                  ),
                  _buildEditableDropdownField(
                    label: 'Stage/Class',
                    icon: Icons.school_outlined,
                    currentValue: _selectedStage,
                    items: stages,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedStage = newValue;
                      });
                    },
                    isEditMode: _isEditMode,
                    originalDisplayValue: user.stage,
                  ),

                  _buildEditableProfileField(
                    label: 'School',
                    controller: _schoolController,
                    icon: Icons.account_balance_outlined,
                    isEditMode: _isEditMode,
                    originalValue: user.school,
                    // Optional: Add validator for school if needed
                  ),

                  const SizedBox(height: 30),
                  if (!_isEditMode)
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Log Out'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to log out?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Log Out', style: TextStyle(
                                        color: theme.colorScheme.error)),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                      _handleLogout();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: theme.colorScheme.onError,
                          backgroundColor: theme.colorScheme.error,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(
      {required IconData icon, required String label, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: Theme
              .of(context)
              .primaryColor
              .withOpacity(0.7), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableProfileField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isEditMode,
    String? originalValue,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isEditMode
          ? TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: theme.primaryColor.withOpacity(0.7)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          fillColor: Colors.grey[50]?.withOpacity(0.7),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 14.0, horizontal: 12.0),
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      )
          : _buildProfileDetailRow(
          icon: icon, label: label, value: originalValue),
    );
  }

  Widget _buildEditableDropdownField({
    required String label,
    required IconData icon,
    required String? currentValue,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isEditMode,
    String? originalDisplayValue,
  }) {
    final theme = Theme.of(context);
    if (isEditMode) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: theme.primaryColor.withOpacity(0.7)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0)),
            filled: true,
            fillColor: Colors.grey[50]?.withOpacity(0.7),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 14.0, horizontal: 12.0),
          ),
          value: currentValue,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Please select a $label' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      );
    } else {
      return _buildProfileDetailRow(
          icon: icon, label: label, value: originalDisplayValue ?? 'N/A');
    }
  }
}