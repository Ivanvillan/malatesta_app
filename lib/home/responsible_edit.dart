import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:malatesta_app/home/responsible_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResponsibleEdit extends StatefulWidget {
  final id;
  ResponsibleEdit({Key key, @required this.id}) : super(key: key);
  @override
  _ResponsibleEditState createState() => _ResponsibleEditState();
}

class _ResponsibleEditState extends State<ResponsibleEdit> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List data = List();
  final _formKey = GlobalKey<FormState>();
  var loading = false;

  TextEditingController nameController;
  TextEditingController lastnameController;
  TextEditingController emailController;
  TextEditingController documentController;
  TextEditingController phoneController;
  TextEditingController addressController;

  @override
  void initState() {
    getResponsible();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Editar'),
          backgroundColor: Color(0xff128f39),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, i) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: nameController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(labelText: 'Ingrese nombre'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person_outline),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: lastnameController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(labelText: 'Ingrese apellido'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: 'Ingrese email'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: addressController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration:
                                InputDecoration(labelText: 'Ingrese direccion'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.phone),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration:
                                InputDecoration(labelText: 'Ingrese teléfono'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 5,
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton(
                        //       hint: Text('Tipo'),
                        //       value: _selectedDocumentType,
                        //       items: _dropdownMenuItems,
                        //       onChanged: onChangeDropdownItem,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        Icon(Icons.format_indent_increase),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: TextFormField(
                            controller: documentController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Documento'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar el campo';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text('Aviso'),
                content: Text('¿Editar responsable?'),
                actions: [
                  FlatButton(
                    child: Text('Si'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();
                      var cookies = localStorage.getString('cookies');
                      var url =
                          'http://200.105.69.227/malatesta-api/public/index.php/persons/save/responsibles';
                      var response = await http.post(url, headers: {
                        'Accept': 'application/json',
                        'Cookie': cookies
                      }, body: {
                        "name": nameController.text,
                        "last_name": lastnameController.text,
                        "email": emailController.text,
                        "phone": phoneController.text,
                        "address": addressController.text,
                        "document_type": 'DNI',
                        "document": documentController.text,
                        "id": widget.id
                      });
                      print(response.statusCode);
                      print(response.body);
                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResponsibleList(
                              paramResponsible: 0,
                            ),
                          ),
                        );
                      } else {
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Error al editar'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(c, false);
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(c, false),
                  ),
                ],
              ),
            );
          },
          backgroundColor: Color(0xffe63c13),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<String> getResponsible() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var cookies = localStorage.getString('cookies');
    var id = widget.id;
    var response = await http.get(
        ('http://200.105.69.227/malatesta-api/public/index.php/persons/get/responsibles/$id'),
        headers: {'Accept': 'application/json', 'Cookie': cookies});
    var body = json.decode(response.body);
    setState(() {
      data = body["result"];
    });
    //
    nameController = new TextEditingController(text: data[0]['name']);
    lastnameController = new TextEditingController(text: data[0]['last_name']);
    emailController = new TextEditingController(text: data[0]['email']);
    addressController = new TextEditingController(text: data[0]['address']);
    documentController = new TextEditingController(text: data[0]['document']);
    phoneController = new TextEditingController(text: data[0]['phone']);
    //
    return "Sucess";
  }
}
