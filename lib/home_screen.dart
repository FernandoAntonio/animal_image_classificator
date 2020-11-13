import 'dart:io';

import 'package:animal_image_model/list_screen.dart';
import 'package:animal_image_model/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;
  File _image;
  List _results;

  Future _loadModel() async {
    await Tflite.loadModel(
      model: 'model/model_unquant.tflite',
      labels: 'model/labels.txt',
    );
  }

  Future _pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _loading = true;
      _image = image;
    });

    classifyImage(image);
  }

  Future classifyImage(File image) async {
    var result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = false;
      _results = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;

    _loadModel().then(
      (value) {
        setState(() {
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: GradientAppBar(
        gradient: FlutterGradients.viciousStance(),
        title: Text('Animal Image Classificator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, ListScreen.id),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: CircularGradientButton(
          child: Icon(Icons.add),
          callback: _pickImage,
          gradient: FlutterGradients.viciousStance(),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //Responsive Function => WidthPercentage(1.0%)
    final Function wp =
        Responsive(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height)
            .wp;

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: _loading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  SizedBox(height: wp(10.0)),
                  _results != null
                      ? GradientCard(
                          gradient: FlutterGradients.viciousStance(),
                          child: Padding(
                            padding: EdgeInsets.all(wp(2.0)),
                            child: Text(
                              _results[0]["label"].toString(),
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        )
                      : GradientCard(
                          gradient: FlutterGradients.viciousStance(),
                          child: Padding(
                            padding: EdgeInsets.all(wp(2.0)),
                            child: Text(
                              'Click on the + to add a new animal image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  SizedBox(height: wp(10.0)),
                  _image != null
                      ? Image.file(
                          _image,
                          width: wp(100.0),
                          fit: BoxFit.fitHeight,
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
