import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/screens/profileStatusPage.dart';

// ignore: must_be_immutable
class ProfileCreatePage extends StatefulWidget {
  String _uid;
  String _email;
  ProfileCreatePage([this._uid, this._email]);

  @override
  _ProfileCreatePageState createState() {
    print(_uid);
    return _ProfileCreatePageState();
  }
}

class _ProfileCreatePageState extends State<ProfileCreatePage> {
  final _formKey = GlobalKey<FormState>();
  File _pickedImageFile;
  File _frenteRGFileImage;
  File _versoRGFileImage;
  Map _formProfile = Map<String, Object>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 720,
    );
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  Future<void> _pickRGFrenteImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _frenteRGFileImage = File(pickedImage.path);
    });
  }

  Future<void> _pickRGVersoimage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _versoRGFileImage = File(pickedImage.path);
    });
  }

  void _submit() async {
    _formKey.currentState.save();
    //print(_formProfile);
    final refProfilePic = FirebaseStorage.instance
        .ref()
        .child('users_profile_pic')
        .child(widget._uid + 'profile.jpg');
    await refProfilePic.putFile(_pickedImageFile).onComplete;
    final urlProfilePic = await refProfilePic.getDownloadURL();

    final refFrenteRG = FirebaseStorage.instance
        .ref()
        .child('users_frente_rg')
        .child(widget._uid + 'frenteRG.jpg');
    await refFrenteRG.putFile(_frenteRGFileImage).onComplete;
    final urlrefFrenteRG = await refFrenteRG.getDownloadURL();

    final refVersoRG = FirebaseStorage.instance
        .ref()
        .child('users_verso_rg')
        .child(widget._uid + 'versoRG.jpg');
    await refVersoRG.putFile(_versoRGFileImage).onComplete;
    final urlrefVersoRG = await refVersoRG.getDownloadURL();

    _formProfile['urlprofile'] = urlProfilePic;
    _formProfile['urlRGFrente'] = urlrefFrenteRG;
    _formProfile['urlRGVerso'] = urlrefVersoRG;
    _formProfile['status'] = 'em analise';

    await Firestore.instance
        .collection('users')
        .document(widget._uid)
        .setData(_formProfile).then((_) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileStatusPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Container(
            color: Colors.green[800],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                FlatButton(
                  onPressed: _pickImage,
                  child: CircleAvatar(
                    backgroundImage: _pickedImageFile != null
                        ? FileImage(_pickedImageFile)
                        : null,
                    radius: 40,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(Icons.verified_user),
                  ),
                ),
                FlatButton.icon(
                    onPressed: () {
                      _pickImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey[400],
                    ),
                    label: Text(
                      'Adicionar foto',
                      style: TextStyle(color: Colors.grey[400]),
                    )),
                Text(
                  widget._email,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                Text(
                  'O seu cadastro irá para análise!\n digite os dados corretamente',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    padding: EdgeInsets.all(32),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          //Nome
                          TextFormField(
                              onSaved: (value) => _formProfile['nome'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Nome Completo')),
                          // Telefone
                          TextFormField(
                            onSaved: (value) => _formProfile['numero'] = double.parse(value),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.phone),
                                  hintText: 'Telefone')),
                          // CPF
                          TextFormField(
                            onSaved: (value) => _formProfile['cpf'] = value,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.credit_card),
                                  hintText: 'CPF')),
                          // Rua
                          TextFormField(
                            onSaved: (value) => _formProfile['rua'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.add_road_outlined),
                                  hintText: 'Rua')),
                          // Bairro
                          TextFormField(
                            onSaved: (value) => _formProfile['bairro'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.location_on),
                                  hintText: 'Bairro')),
                          // Cidade
                          TextFormField(
                            onSaved: (value) => _formProfile['cidade'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.location_city),
                                  hintText: 'Cidade')),
                          // Estado
                          TextFormField(
                            onSaved: (value) => _formProfile['estado'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.location_city),
                                  hintText: 'Estado')),
                          // Profissão
                          TextFormField(
                            onSaved: (value) => _formProfile['profissao'] = value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.work),
                                  hintText: 'Profissão')),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  FlatButton(
                                    onPressed: _pickRGFrenteImage,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          _frenteRGFileImage != null
                                              ? FileImage(_frenteRGFileImage)
                                              : null,
                                      radius: 40,
                                      backgroundColor: Colors.deepOrange,
                                      child: Icon(Icons.verified_user),
                                    ),
                                  ),
                                  FlatButton.icon(
                                      onPressed: () {
                                        _pickRGFrenteImage();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      label: Text(
                                        'Frente do RG',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  FlatButton(
                                    onPressed: _pickRGVersoimage,
                                    child: CircleAvatar(
                                      backgroundImage: _versoRGFileImage != null
                                          ? FileImage(_versoRGFileImage)
                                          : null,
                                      radius: 40,
                                      backgroundColor: Colors.deepOrange,
                                      child: Icon(Icons.verified_user),
                                    ),
                                  ),
                                  FlatButton.icon(
                                      onPressed: () {
                                        _pickRGVersoimage();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      label: Text(
                                        'Verso do RG',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonRounded('SALVAR', Colors.deepOrange, () {
                            _submit();
                          }),
                          Container(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
