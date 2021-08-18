import 'package:dc_qr_test/decode_message.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_flutter/qrcode_flutter.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(_MyPage());

class _MyPage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<_MyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("qrcode_flutter"),
      ),
      body: Builder(
        builder: (context) => RaisedButton(
          child: Text("navigate to qrcode page"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => _MyApp()));
          },
        ),
      ),
    ));
  }
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> with TickerProviderStateMixin {
  QRCaptureController _controller = QRCaptureController();

  bool _isTorchOn = false;

  String _captureText = '';

  @override
  void initState() {
    super.initState();

    _controller.onCapture((data) {
      print('here I log data $data');
      setState(() {
        _captureText = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scan'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              PickedFile? image =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              QRCaptureController.getQrCodeByImagePath(image!.path)
                  .then((code) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DecodePage(
                                title: 'Decode QR Code', codeToDecode: code[0]),
                          ),
                        )
                      });

              //print('here I log qrCodeResult $qrCodeResult');
              //setState(() {
              //  _captureText = qrCodeResult.join('\n');
              //});
            },
            child: Text('photoAlbum', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: QRCaptureView(
              controller: _controller,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildToolBar(),
            ),
          ),
          Container(
            child: Text('$_captureText'),
          )
        ],
      ),
    );
  }

  Widget _buildToolBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _controller.pause();
          },
          child: Text('pause'),
        ),
        FlatButton(
          onPressed: () {
            if (_isTorchOn) {
              _controller.torchMode = CaptureTorchMode.off;
            } else {
              _controller.torchMode = CaptureTorchMode.on;
            }
            _isTorchOn = !_isTorchOn;
          },
          child: Text('torch'),
        ),
        FlatButton(
          onPressed: () {
            _controller.resume();
          },
          child: Text('resume'),
        ),
      ],
    );
  }
}
