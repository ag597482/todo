import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:todo/screens/picture.dart';

class Page75 extends StatefulWidget {
  const Page75({super.key});

  @override
  State<Page75> createState() => _Page75State();
}

class _Page75State extends State<Page75> {
  bool waterGoal = false;
  bool readinGoal = false;
  bool photoGoal = false;
  List<bool> exersieList = [false, false];
  List<bool> dietList = [false, false, false, false];
  int waterDrank = 0;

  getGauge(int val, int total, int heightVal) {
    return Container(
      height: heightVal.toDouble(),
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: total.toDouble(),
          showLabels: false,
          showTicks: false,
          axisLineStyle: AxisLineStyle(
            thickness: 0.15,
            cornerStyle: CornerStyle.bothCurve,
            color: Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  '$val / $total',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ))
          ],
          pointers: <GaugePointer>[
            RangePointer(
              value: val.toDouble(),
              cornerStyle: CornerStyle.bothCurve,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            )
          ],
        ),
      ]),
    );
  }

  getDivider() {
    return const Divider(
      height: 2,
      thickness: 1.0,
      indent: 5,
      endIndent: 5,
    );
  }

  getTrailingIconFromLIst(boolList) {
    int done = 0;
    int total = boolList.length;
    for (bool val in boolList) {
      if (val) {
        done++;
      }
    }
    return getTrailingIcon(done, total);
  }

  getTrailingIcon(int done, int total) {
    if (done >= total) {
      return const Icon(
        Icons.done,
        color: Colors.green,
      );
    }
    return Container(
      width: 25,
      height: 25,
      child: CircularProgressIndicator(
        value: done / total,
        color: Colors.green,
        backgroundColor: Colors.grey,
      ),
    );
  }

  getExersiseItem() {
    return ExpansionTile(
      title: const Text('Exersise Twice'),
      subtitle: const Text('Atlease 1 exersie should be outdoor'),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: getTrailingIconFromLIst(exersieList),
      children: <Widget>[
        CheckboxListTile(
            value: exersieList[0],
            onChanged: (bool? value) {
              setState(() {
                exersieList[0] = value!;
              });
            },
            title: const Text('Exersise 1')),
        CheckboxListTile(
          value: exersieList[1],
          onChanged: (bool? value) {
            setState(() {
              exersieList[1] = value!;
            });
          },
          title: const Text('Exersise 2'),
        ),
      ],
    );
  }

  getDietItem() {
    return ExpansionTile(
      title: const Text('Follow a Diet'),
      subtitle: const Text('Get Good Nutrients'),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: getTrailingIconFromLIst(dietList),
      children: <Widget>[
        CheckboxListTile(
            value: dietList[0],
            onChanged: (bool? value) {
              setState(() {
                dietList[0] = value!;
              });
            },
            title: const Text('Good Breakfast')),
        CheckboxListTile(
            value: dietList[1],
            onChanged: (bool? value) {
              setState(() {
                dietList[1] = value!;
              });
            },
            title: const Text('Healthy Lunch')),
        CheckboxListTile(
            value: dietList[2],
            onChanged: (bool? value) {
              setState(() {
                dietList[2] = value!;
              });
            },
            title: const Text('Dry Fruits & Milk Snacks')),
        CheckboxListTile(
            value: dietList[3],
            onChanged: (bool? value) {
              setState(() {
                dietList[3] = value!;
              });
            },
            title: const Text('4 Eggs')),
      ],
    );
  }

  getWaterItem() {
    return ExpansionTile(
      title: const Text('Drink Sufficient Water'),
      subtitle: const Text('Drink 4L Of Water Daily'),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: getTrailingIcon(waterDrank, 8),
      children: <Widget>[
        ListTile(
          title: Text("Add 250ml Water"),
          trailing: IconButton(
            icon: Icon(Icons.water_drop_rounded),
            onPressed: () {
              setState(() {
                if (waterDrank < 8) waterDrank++;
              });
            },
          ),
        ),
        CheckboxListTile(
          value: waterGoal || waterDrank == 8,
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                waterDrank = 8;
              }
              waterGoal = value!;
            });
          },
          title: const Text('4L Completed'),
        ),
      ],
    );
  }

  getReadItem() {
    return ExpansionTile(
      title: const Text('Book Reading'),
      subtitle: const Text('Read 10 Pages of Non-fiction'),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: getTrailingIconFromLIst([readinGoal]),
      children: <Widget>[
        CheckboxListTile(
          value: readinGoal,
          onChanged: (bool? value) {
            setState(() {
              readinGoal = value!;
            });
          },
          title: const Text('Read 10 pages'),
        ),
      ],
    );
  }

  getPhotoItem() {
    return ExpansionTile(
      title: const Text('Photo'),
      subtitle: const Text('Take a Photo'),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: getTrailingIconFromLIst([photoGoal]),
      children: <Widget>[
        IconButton(
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              final cameras = await availableCameras();
              final firstCamera = cameras.first;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                    camera: firstCamera,
                  ),
                ),
              );
            },
            icon: Icon(Icons.camera)),
        CheckboxListTile(
          value: photoGoal,
          onChanged: (bool? value) {
            setState(() {
              photoGoal = value!;
            });
          },
          title: const Text('Save Photo'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            getGauge(6, 75, 180),
            getDivider(),
            getExersiseItem(),
            getDietItem(),
            getWaterItem(),
            getReadItem(),
            getPhotoItem()
            // Checkbox(
            //   value: showvalue,
            //   onChanged: (value) {
            //     setState(() {
            //       showvalue = value!;
            //       checkboxValue1 = value;
            //     });
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
