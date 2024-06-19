import 'package:flutter/material.dart';
import 'package:task/businessImagesPage.dart';

class DetailPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Business Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: DetailForm(),
      ),
    );
  }
}

class DetailForm extends StatefulWidget {
  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  int _descriptionMaxLines = 1;
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter business name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: _descriptionMaxLines,
                maxLength: 500, // Limit characters to 500
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter business description';
                  } else if (value.length > 500) {
                    return 'Description must not exceed 500 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    _descriptionMaxLines =
                        _descriptionMaxLines < 5 ? _descriptionMaxLines + 1 : 5;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter business address';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter city';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _stateController,
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter state';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _countryController,
            decoration: InputDecoration(labelText: 'Country'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter country';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _pincodeController,
            decoration: InputDecoration(labelText: 'Pincode'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter pincode';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessImagesPage()),
                );
                print('Name: ${_nameController.text}');
                print('Description: ${_descriptionController.text}');
                print('Address: ${_addressController.text}');
                print('City: ${_cityController.text}');
                print('State: ${_stateController.text}');
                print('Country: ${_countryController.text}');
                print('Pincode: ${_pincodeController.text}');
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
