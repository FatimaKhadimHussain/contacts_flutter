import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/utils/constants.dart';
import '../../../domain/entities/contacts/contact_item.dart';
import '../../bloc/contacts/contacts_bloc.dart';
import 'loading_indicator.dart';

class AddUpdateContactForm extends StatefulWidget {
  const AddUpdateContactForm({
    super.key,
    required this.contact,
    required this.mode,
  });

  final Contact contact;
  final ContactScreenMode mode;

  @override
  State<AddUpdateContactForm> createState() => _AddUpdateContactFormState();
}

enum PickerType { camera, gallery }

class _AddUpdateContactFormState extends State<AddUpdateContactForm> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  Uint8List? bytes;

  Future<void> selectImageFromPickerOption() async {
    switch (await showDialog<ImagePickerSourceType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select image from'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImagePickerSourceType.camera);
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImagePickerSourceType.gallery);
                },
                child: const Text('Photo Gallery'),
              ),
            ],
          );
        })) {
      case ImagePickerSourceType.camera:
        await pickImage(ImagePickerSourceType.camera);
        break;
      case ImagePickerSourceType.gallery:
        await pickImage(ImagePickerSourceType.gallery);
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  Future pickImage(ImagePickerSourceType pickerType) async {
    try {
      var photo = await ImagePicker().pickImage(
        source: pickerType == ImagePickerSourceType.gallery
            ? ImageSource.gallery
            : ImageSource.camera,
        imageQuality: 80,
      );

      File imageFile = File(photo!.path);
      Uint8List imageRaw = await imageFile.readAsBytes();
      setState(() {
        widget.contact.photo = imageRaw;
      });

      return imageRaw;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoading) {
          return const LoadingIndicator();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        // contact name field
                        SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  selectImageFromPickerOption();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  minRadius: 40.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 38.0,
                                    backgroundImage: widget.contact.photo ==
                                            null
                                        ? null
                                        : MemoryImage(widget.contact.photo!),
                                    child: widget.contact.photo == null
                                        ? const Icon(
                                            Icons.photo_camera,
                                            size: 35.0,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ContactInputView(
                          title: 'Name',
                          initialValue: widget.contact.name,
                          keyboardType: TextInputType.name,
                          changedValue: (value) {
                            widget.contact.name = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact name';
                            }
                            return null;
                          },
                        ),

                        const Padding(padding: EdgeInsets.all(12)),
                        // mobile field
                        ContactInputView(
                          title: 'Mobile',
                          initialValue: widget.contact.mobile,
                          keyboardType: TextInputType.phone,
                          changedValue: (value) {
                            widget.contact.mobile = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (value.length < 10) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                        ),

                        const Padding(padding: EdgeInsets.all(12)),

                        ContactInputView(
                          title: 'Landline',
                          initialValue: widget.contact.landline,
                          keyboardType: TextInputType.phone,
                          changedValue: (value) {
                            widget.contact.landline = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (value.length < 10) {
                              return 'Please enter valid landline number';
                            }
                            return null;
                          },
                        ),

                        // save
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                key: const Key(
                                    'AddContactForm_save_update_raisedButton'),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // add or update the contact based on the mode
                                    context.read<ContactsBloc>().add(
                                        widget.mode == ContactScreenMode.add
                                            ? AddContactEvent(
                                                contact: widget.contact)
                                            : UpdateContactEvent(
                                                contact: widget.contact));
                                  }
                                },
                                child: Text(widget.mode == ContactScreenMode.add
                                    ? 'Save'
                                    : 'Update'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }
      },
    );
  }
}

class ContactInputView extends StatelessWidget {
  final String title;
  String? initialValue;
  final TextInputType? keyboardType;
  final Function(String?)? changedValue;
  final String? Function(String?)? validator;

  ContactInputView(
      {super.key,
      required this.title,
      this.initialValue,
      this.keyboardType,
      this.changedValue,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: keyboardType,
              decoration: kTextFieldDecoration,
              onChanged: changedValue,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
