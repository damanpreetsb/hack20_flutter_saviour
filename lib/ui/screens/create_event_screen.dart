import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saviour/service/firebase_service.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var time = TimeOfDay.now();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        startDateController.value =
            TextEditingValue(text: DateFormat.yMMMd().format(picked));
      });
  }

  Future<Null> _selectTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime =
          localizations.formatTimeOfDay(t, alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          startTimeController.value = TextEditingValue(text: formattedTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: () {
                        _selectDate(
                            context); // Call Function that has showDatePicker()
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter start date';
                            }
                            return null;
                          },
                          controller: startDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Start date',
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: () {
                        _selectTime(); // Call Function that has showDatePicker()
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter start time';
                            }
                            return null;
                          },
                          controller: startTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Start time',
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          FirebaseService firebaseService = FirebaseServiceImpl();
                        }
                      },
                      child: Text('Upload'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}