import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/components/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/button.dart';

import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/config.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  Map<String, dynamic> user = {};

  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  String? _selectedImage;

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();

    XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_photo_path', selectedImage.path);
      setState(() {
        _selectedImage = selectedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the initial values from the user object
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    phoneController.text = user['phone'] ?? '';
    addressController.text = user['address'] ?? '';
    positionController.text = user['position'] ?? '';
    _selectedImage = user['profile_photo_path'] ?? '';

  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Edit Your Information',
        icon: FaIcon(Icons.arrow_back_ios),
        route: 'main',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await _selectImage();
                    if (_selectedImage != null) {
                      authModel.updatePhoto(_selectedImage!);
                    }
                  },
                  child: _selectedImage != null
                      ? CircleAvatar(
                          radius: 65.0,
                          backgroundImage: FileImage(
                            File(_selectedImage!),
                          ),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 65.0,
                          child: Icon(
                            Icons.image,
                            color: Colors.teal,
                          ),
                        ),
                ),
                Config.spaceMedium,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Config.primaryColor,
                  ),
                  initialValue: user['name'],
                  enabled: false,
                ),
                Config.spaceSmall,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                  initialValue: user['email'],
                  enabled: false,
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.phone),
                    prefixIconColor: Config.primaryColor,
                  ),
                  onChanged: (value) {
                    authModel.updatePhone(value);
                  },
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    labelText: 'Address',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.location_on_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                  onChanged: (value) {
                    authModel.updateAddress(value);
                  },
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: positionController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Playing Position',
                    labelText: 'Playing Position',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.sports_handball_sharp),
                    prefixIconColor: Config.primaryColor,
                  ),
                  onChanged: (value) {
                    authModel.updatePosition(value);
                  },
                ),
                Config.spaceMedium,
                Button(
                  width: double.infinity,
                  title: 'Save',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';

                      // Get the updated values from the form fields
                      String phone = phoneController.text;
                      String address = addressController.text;
                      String position = positionController.text;

                      // Call the updateUserDetails method from the AuthModel
                      var response = await DioProvider()
                          .updateUser(token, phone, address, position);
                      if (_selectedImage != null) {
                        await DioProvider()
                            .updatePhoto(token, _selectedImage.toString());
                      }
                      if (response == 200) {
                        // User details updated successfully
                        // Show a success message or navigate to a different screen if desired

                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text(
                                  'User information updated successfully.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Error occurred while updating user details
                        // Show an error message or handle the error appropriately
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Failed to update user information.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  disable: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
