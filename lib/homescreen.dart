import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'contactWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String currentText = '';
  String currentEmail = '';
  String currentPhone = '';
  String? emailError;
  String? phoneError;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<Contactwidget> contacts = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.asset("assets/images/route.png"),
        ),
        leadingWidth: 190,
        backgroundColor: const Color(0XFF29384D),
      ),
      backgroundColor: const Color(0XFF29384D),
      body: Column(
        children: [
          if (contacts.isEmpty) ...[
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Lottie.asset(
                "assets/animation/empty_list.json",
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            const Text(
              "There is No Contacts Added Here",
              style: TextStyle(
                color: Color(0XFFFFF1D4),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: 'add_contact_empty',
                  onPressed: () {
                    bottom_bar(context);
                  },
                  backgroundColor: const Color(0XFFFFF1D4),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: contacts.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.58,
                      ),
                      itemBuilder: (context, index) {
                        final item = contacts[index];
                        return Contactwidget(
                          name: item.name,
                          email: item.email,
                          image: item.image,
                          phone: item.phone,
                          onDelete: () {
                            setState(() {
                              contacts.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                          heroTag: 'delete_last_contact',
                          onPressed: () {
                            setState(() {
                              contacts.removeLast();
                            });
                          },
                          backgroundColor: const Color(0XFFF93E3E),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        FloatingActionButton(
                          heroTag: 'add_contact',
                          onPressed: () {
                            bottom_bar(context);
                          },
                          backgroundColor: const Color(0XFFFFF1D4),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void bottom_bar(BuildContext context) {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    currentText = '';
    currentEmail = '';
    currentPhone = '';
    emailError = null;
    phoneError = null;
    _image = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                margin: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0XFF29384D),
                  borderRadius: BorderRadius.circular(28),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final XFile? pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedFile != null) {
                                setModalState(() {
                                  _image = File(pickedFile.path);
                                });
                              }
                            },
                            child: _image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.file(
                                _image!,
                                width: 143,
                                height: 146,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              width: 143,
                              height: 146,
                              decoration: BoxDecoration(
                                color: const Color(0xFF29384D),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: const Color(0xFFFFF1D4),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Center(
                                  child: Lottie.asset(
                                    "assets/animation/image_picker.json",
                                    width: 115,
                                    height: 115,
                                    repeat: true,
                                    reverse: true,
                                    animate: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  currentText.trim().isEmpty
                                      ? "username"
                                      : currentText,
                                  style: const TextStyle(
                                    color: Color(0XFFFFF1D4),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Divider(
                                  color: Color(0XFFFFF1D4),
                                  thickness: 1,
                                  height: 12,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  currentEmail.trim().isEmpty
                                      ? "example@email.com"
                                      : currentEmail,
                                  style: const TextStyle(
                                    color: Color(0XFFFFF1D4),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Divider(
                                  color: Color(0XFFFFF1D4),
                                  thickness: 1,
                                  height: 12,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  currentPhone.trim().isEmpty
                                      ? "+20000000"
                                      : currentPhone,
                                  style: const TextStyle(
                                    color: Color(0XFFFFF1D4),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Divider(
                                  color: Color(0XFFFFF1D4),
                                  thickness: 1,
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: TextField(
                          controller: _nameController,
                          onChanged: (value) {
                            setModalState(() {
                              currentText = value;
                            });
                          },
                          style: const TextStyle(color: Color(0xFFFFF1D4)),
                          cursorColor: const Color(0xFFFFF1D4),
                          cursorRadius: const Radius.circular(16),
                          decoration: InputDecoration(
                            labelText: 'Enter User Name',
                            labelStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            hintStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setModalState(() {
                              currentEmail = value;
                              if (emailError != null) {
                                emailError = _validateEmail(value);
                              }
                            });
                          },
                          style: const TextStyle(color: Color(0xFFFFF1D4)),
                          cursorColor: const Color(0xFFFFF1D4),
                          cursorRadius: const Radius.circular(16),
                          decoration: InputDecoration(
                            labelText: 'Enter User Email',
                            errorText: emailError,
                            errorStyle:
                            const TextStyle(color: Colors.redAccent),
                            labelStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            hintStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setModalState(() {
                              currentPhone = value;
                              if (phoneError != null) {
                                phoneError = _validatePhone(value);
                              }
                            });
                          },
                          style: const TextStyle(color: Color(0xFFFFF1D4)),
                          cursorColor: const Color(0xFFFFF1D4),
                          cursorRadius: const Radius.circular(16),
                          decoration: InputDecoration(
                            labelText: 'Enter User Phone',
                            errorText: phoneError,
                            errorStyle:
                            const TextStyle(color: Colors.redAccent),
                            labelStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            hintStyle:
                            const TextStyle(color: Color(0xFFFFF1D4)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFFFF1D4),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            setModalState(() {
                              emailError = _validateEmail(currentEmail);
                              phoneError = _validatePhone(currentPhone);
                            });

                            if (emailError == null && phoneError == null) {
                              setState(() {
                                contacts.add(
                                  Contactwidget(
                                    name: currentText.trim(),
                                    email: currentEmail.trim(),
                                    image: _image?.path ?? '',
                                    phone: currentPhone.trim(),
                                  ),
                                );
                              });
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF1D4),
                            foregroundColor: const Color(0xFF29384D),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Enter user',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? _validateEmail(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(trimmed)) {
      return 'Enter a valid phone number (8–15 digits)';
    }
    return null;
  }
}