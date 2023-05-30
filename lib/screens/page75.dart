import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:todo/globals.dart';
import 'package:todo/screens/picture.dart';
import 'package:todo/utils/shared_pref_helper.dart';

class Page75 extends StatefulWidget {
  const Page75({super.key});

  @override
  State<Page75> createState() => _Page75State();
}

class _Page75State extends State<Page75> {
  SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  @override
  void initState() {
    // super.initState();
    setState(() {
      sharedPreferenceService
          .getIntVal("streak")
          .then((value) => streak = value);
      sharedPreferenceService
          .getIntVal("waterGoal")
          .then((value) => waterGoal = value == 1);
      sharedPreferenceService
          .getIntVal("waterDrank")
          .then((value) => waterDrank = value);
      sharedPreferenceService
          .getIntVal("readingGoal")
          .then((value) => readingGoal = value == 1);
      sharedPreferenceService
          .getIntVal("photoGoal")
          .then((value) => photoGoal = value == 1);
      sharedPreferenceService.getStringVal("dietGoal").then((value) {
        dietList[0] = value[0] == '1';
        dietList[1] = value[1] == '1';
        dietList[2] = value[2] == '1';
        dietList[3] = value[3] == '1';
      });
      sharedPreferenceService.getStringVal("exersiseGoal").then((value) {
        exersieList[0] = value[0] == '1';
        exersieList[1] = value[1] == '1';
      });
    });
  }

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
            color: const Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  '$val / $total',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w400),
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

  getSuccessIcon() {
    return const Icon(
      Icons.done,
      color: Colors.green,
    );
  }

  allGoalsAcheved() {
    if (waterGoal &&
        readingGoal &&
        getTrailingIconFromLIst(dietList) == getSuccessIcon() &&
        getTrailingIconFromLIst(exersieList) == getSuccessIcon()) {
      return true;
    }
    return false;
  }

  getProgressState() {
    String text = allGoalsAcheved() ? "TODAY'S GOAL COMPLTED" : "IN PROGRESS";
    Color colorValue = allGoalsAcheved() ? Colors.green : Colors.amber;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colorValue),
      ),
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
      return getSuccessIcon();
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
                exersiseGoal.replaceRange(0, 1, exersieList[0] ? '1' : '0');
              });
            },
            title: const Text('Exersise 1')),
        CheckboxListTile(
          value: exersieList[1],
          onChanged: (bool? value) {
            setState(() {
              exersieList[1] = value!;
              exersiseGoal.replaceRange(1, 2, exersieList[1] ? '1' : '0');
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
                dietGoal.replaceRange(0, 1, dietList[0] ? '1' : '0');
              });
            },
            title: const Text('Good Breakfast')),
        CheckboxListTile(
            value: dietList[1],
            onChanged: (bool? value) {
              setState(() {
                dietList[1] = value!;
                dietGoal.replaceRange(1, 2, dietList[1] ? '1' : '0');
              });
            },
            title: const Text('Healthy Lunch')),
        CheckboxListTile(
            value: dietList[2],
            onChanged: (bool? value) {
              setState(() {
                dietList[2] = value!;
                dietGoal.replaceRange(2, 3, dietList[2] ? '1' : '0');
              });
            },
            title: const Text('Dry Fruits & Milk Snacks')),
        CheckboxListTile(
            value: dietList[3],
            onChanged: (bool? value) {
              setState(() {
                dietList[3] = value!;
                dietGoal.replaceRange(3, 4, dietList[3] ? '1' : '0');
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
          title: const Text("Add 250ml Water"),
          trailing: IconButton(
            icon: const Icon(Icons.water_drop_rounded),
            onPressed: () {
              setState(() {
                if (waterDrank < 8) {
                  waterDrank++;
                }
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
              sharedPreferenceService.updateIntVal("waterDrank", waterDrank);
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
      trailing: getTrailingIconFromLIst([readingGoal]),
      children: <Widget>[
        CheckboxListTile(
          value: readingGoal,
          onChanged: (bool? value) {
            setState(() {
              readingGoal = value!;
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
        ListTile(
          title: const Text("Save Photo"),
          trailing: IconButton(
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    sharedPreferenceService.updateStringVal("exersiseGoal", exersiseGoal);
    sharedPreferenceService.updateIntVal("waterGoal", waterGoal ? 1 : 0);
    sharedPreferenceService.updateIntVal("readingGoal", readingGoal ? 1 : 0);
    sharedPreferenceService.updateIntVal("waterDrank", waterDrank);
    sharedPreferenceService.updateStringVal("dietGoal", dietGoal);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            getGauge(streak, 75, 180),
            getDivider(),
            getProgressState(),
            getExersiseItem(),
            getDietItem(),
            getWaterItem(),
            getReadItem(),
            getPhotoItem()
          ],
        ),
      ),
    ));
  }
}
