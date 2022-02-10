import 'package:flutter/material.dart';
import 'package:ui_login/shape_honor.dart';
import 'package:ui_login/shape_lip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  late AnimationController controllerCr;
  late Animation<double> valueAnimationCr;

  final double  _marginTop = 90;
  var color =Colors.transparent;
  double valueY=10;
  String statusText ='Very Bad';
  @override
  void initState() {
    super.initState();
    controllerCr = AnimationController(vsync: this,
    duration: const Duration(
      seconds: 2,
    ));
    valueAnimationCr = Tween<double>(
      begin: 0.0,
      end: 1
    ).animate(controllerCr)..addStatusListener((status) {
      if(status== AnimationStatus.completed)
      {
        color=Colors.yellow;
      }


    })..addListener(() { setState(() {

    });});
    controllerCr.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Custom Painter"),
      ),
      body:  Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          AnimatedOpacity(
            duration: const Duration(
              seconds: 1
            ),
            opacity: valueAnimationCr.value,
            child: Container(
             alignment: Alignment.center,

              height: 50,
              width:200,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30), //border corner radius
              gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00CCFF),
                   Colors.blue,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),

              child: Center(
                child: Text(
                  statusText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    foreground: Paint()..color=Colors.white
                  ),
                ),
              ),
            ),
          ),

            SizedBox(
              width: 320,
              height: 310,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: AnimatedContainer(
                      height: 280,
                      width: MediaQuery.of(context).size.width/1.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color
                      ),
                      duration: Duration(seconds: 1),
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                        value: valueAnimationCr.value,
                      ),
                    ),
                  ),
                  _reputationWidget(
                      top: _marginTop - 30,
                      right: 85,
                  ),
                  _reputationWidget(
                      top: _marginTop - 30,
                      left: 85,
                  ),
                 // _noseWidget(),

                  _eyeWidget(
                    top: _marginTop,
                    right: 80
                  ),
                  _eyeWidget(
                    top: _marginTop,
                      left: 80,
                  ),

                  _lipWidget()
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.8,
              child: Slider(
                min: 10.0,
                  max: 70,
                  value: valueY,
                  onChanged: (value) {

                    setState(() {
                      valueY=value;
                      print(valueY.ceil());
                      changeStatusText(value.ceil());
                    });
                  },),
            ),
            const Text(
              'Swipe Right Or Left',
              style: TextStyle(
              fontSize: 16,
              color: Colors.grey),
            )

          ],
        ),
      ),

    );
  }

  void changeStatusText(int value)
  {
    /// value == 20 'bad'
    /// value == 40 'Not bad'
    /// value == 40 'Good'
    /// value == 70 'very Good'
    switch(value)
    {
      case 10: {
        statusText = 'Very bad';
      }
     break;
      case 25: {
        statusText = 'Bad';
      }
      break;
      case 40 :{
        statusText = 'Not Bad';
      }
      break;
      case 55:
        {
          statusText = 'Good';
        }
        break;
      case 70:
        {
          statusText = 'Very Good';
        }
        break;
    }

  }

  _reputationWidget({double? right, double? left, double? top})
  {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: CustomPaint(
        painter: const ShapeLip(valueY: 10,),
        child: Container(
          width: 40,
          height: 40,
        ),
      ),
    );
  }
  _noseWidget ()
  {
    return Positioned(
        top: _marginTop + 15,
        left: 160,
        width: 80,
        child: Transform(
          transform:Matrix4.rotationZ(1.8),
          child: CustomPaint(
            painter: ShapePainter(),
            child: Container(),
          ),
        )

    );
  }
  _eyeWidget({required double top,double? left,double? right})
  {
    return  Positioned(
      top: top,
      right: right,
      left: left,
      child:
      ScaleTransition(
        scale: valueAnimationCr,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
          ),
          height: 50,
          width: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 1,
                ),
              ),
              const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 2,
                  value: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _lipWidget()
  {
    return  Positioned(
        bottom: 50,
        child:
        CustomPaint(
          painter: ShapeLip(valueY: valueY,),
          child: Container(
            width: valueAnimationCr.value *100,
            height: 70,
          ),
        )
    );
  }
}

class ShapePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate
      ) {
    return true;
  }

}




class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
