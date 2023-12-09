import 'dart:convert';
import 'package:annoucement_form/Screen/preview_page.dart';
import 'package:annoucement_form/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:annoucement_form/widgets/custom_scaffold.dart';
import 'package:annoucement_form/theme/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Contactpage extends StatefulWidget {
  const Contactpage({super.key});

  @override
  State<Contactpage> createState() => _ContactpageState();
}

class _ContactpageState extends State<Contactpage> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  final TextEditingController desc = TextEditingController();
  final TextEditingController add = TextEditingController();
  final TextEditingController pos = TextEditingController();
  final TextEditingController sal = TextEditingController();
  final TextEditingController req = TextEditingController();
  final TextEditingController con = TextEditingController();

  naviagtion(id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => PreviewPage(id: id)),
      ),
    );
  }

  void clearText() {
    desc.clear();
    add.clear();
    pos.clear();
    sal.clear();
    req.clear();
    con.clear();
  }

  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                // get started form
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      Text(
                        'Annoucement Form',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // full name
                      TextFormField(
                        controller: desc,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Description'),
                          hintText: 'Enter Description',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // email
                      TextFormField(
                        controller: add,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Address'),
                          hintText: 'Enter Address',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // password
                      TextFormField(
                        controller: pos,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Positions';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Positions'),
                          hintText: 'Enter Positions',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // full name
                      TextFormField(
                        controller: sal,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Salary Approx';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Salary Approx'),
                          hintText: 'Enter  Salary Approx',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        controller: req,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter requrement';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Requirement'),
                          hintText: 'Enter Requirement',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: con,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter requrement';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Contact'),
                          hintText: 'Enter Contact Numbers',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignupKey.currentState!.validate()) {
                              EasyLoading.show(status: 'loading...');
                              try {
                                var data = {
                                  "description": desc.text,
                                  "address": add.text,
                                  "position": pos.text,
                                  "sapprox": sal.text,
                                  "requirement": req.text,
                                  "contacts": con.text.toString()
                                };
                                var res =
                                    await DataModel().sendData(data, "data");
                                Map<String, dynamic> decodedData =
                                    jsonDecode(res.body);

                                var id = decodedData['picdata']['_id'];
                                naviagtion(id);
                              } catch (e) {
                                AlertDialog(
                                  title: Text(e.toString()),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text("Cancel"),
                                    )
                                  ],
                                );
                              } finally {
                                EasyLoading.dismiss();
                              }
                            }
                            // clearText();
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    desc.dispose();
    pos.dispose();
    add.dispose();
    sal.dispose();
    req.dispose();
    con.dispose();
    super.dispose();
  }
}
