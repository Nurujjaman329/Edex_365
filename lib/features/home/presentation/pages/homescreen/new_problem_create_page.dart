import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewProblemCreate extends StatefulWidget {
  @override
  _NewProblemCreateState createState() => _NewProblemCreateState();
}

class _NewProblemCreateState extends State<NewProblemCreate> {
  // Dropdown values
  String dropdownValue1 = 'Option 1';
  String dropdownValue2 = 'Option 1';
  String dropdownValue3 = 'Option 1';

  // Image file
  XFile? selectedImage;

  // Description text controller
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: 'Dropdown 1',
                decoration: InputDecoration(
                  labelText: 'Dropdown 1',
                  border: OutlineInputBorder(),
                  suffixIcon: DropdownButtonFormField(
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    value: dropdownValue1,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                    },
                    items: <String>[
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: 'Dropdown 2',
                decoration: InputDecoration(
                  labelText: 'Dropdown 2',
                  border: const OutlineInputBorder(),
                  suffixIcon: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    value: dropdownValue2,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <String>[
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: 'Dropdown 3',
                decoration: InputDecoration(
                  labelText: 'Dropdown 3',
                  border: OutlineInputBorder(),
                  suffixIcon: DropdownButtonFormField(
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    value: dropdownValue3,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue3 = newValue!;
                      });
                    },
                    items: <String>[
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _takePhoto();
                },
                child: Text('Upload Image'),
              ),
              SizedBox(height: 16),
              selectedImage != null
                  ? Image.file(
                File(
                  selectedImage!.path,
                ),
                height: 100,
                width: 100,
              )
                  : SizedBox.shrink(),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement submit logic
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Camera"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Gallery"),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return;
    final image = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }
}
