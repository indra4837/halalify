import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/header.dart';

import '../pages/capture_ingredient_page.dart';

// A screen that allows users to take a picture using a given camera.
class CaptureObjectScreen extends StatefulWidget {
  final CameraDescription camera;

  const CaptureObjectScreen({
    Key key,
    this.camera,
  }) : super(key: key);

  @override
  CaptureScreenState createState() => CaptureScreenState();
}

class CaptureScreenState extends State<CaptureObjectScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        final mediaSize = MediaQuery.of(context).size;
        final scale =
            1 / (_controller.value.aspectRatio * mediaSize.aspectRatio);
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Scaffold(
            body: SafeArea(
              minimum: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
              child: Column(
                children: [
                  HeaderLogo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    // width: MediaQuery.of(context).size.width,
                    child: Transform.scale(
                      scale: scale,
                      child: CameraPreview(_controller),
                      // aspectRatio: _controller.value.aspectRatio,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        child: Text(
                          'Capture Food',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // Take the Picture in a try / catch block. If anything goes wrong,
                          // catch the error.
                          try {
                            // Ensure that the camera is initialized.
                            await _initializeControllerFuture;

                            // Attempt to take a picture and get the file `image`
                            // where it was saved.
                            final image = await _controller.takePicture();

                            // TODO: save picture of food onto phone for later
                            // _picker.getImage(source: image.);

                            // If the picture was taken, display it on a new screen.
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CaptureIngredientScreen(
                                  // Pass the automatically generated path to
                                  // the DisplayPictureScreen widget.
                                  camera: widget.camera,
                                  foodPath: image.path,
                                ),
                              ),
                            );
                          } catch (e) {
                            // If an error occurs, log the error to the console.
                            print(e);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        child: Text(
                          'Back',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(fontSize: 18),
                            color: Colors.black,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Otherwise, display a loading indicator.
          return Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
