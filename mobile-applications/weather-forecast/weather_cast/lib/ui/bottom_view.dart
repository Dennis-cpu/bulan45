import 'package:flutter/material.dart';

import '../model/weather.dart';
import 'forecast_card.dart';

class BottomView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const BottomView({required Key key, required this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "7-Day Weather Forecast".toUpperCase(),
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: snapshot.data!.list.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 160,
                  child: forecastCard(snapshot, index),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff9661C3), Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                ),
              )),
        )
      ],
    );
  }
}


Widget bottomView(
    AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecastList = snapshot.data!.list;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "7-Day Weather Forecast".toUpperCase(),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
      Container(
        height: 170,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: forecastList.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 160,
                child: forecastCard(snapshot, index),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff9661C3), Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
            )),
      )
    ],
  );
}
