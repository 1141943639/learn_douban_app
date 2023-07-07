import 'package:airship_flutter/airship_flutter.dart';
import 'package:copy_to_app/utils/log_helper.dart';
import 'package:flutter/material.dart';

class LearnAirship extends StatefulWidget {
  const LearnAirship({super.key});

  @override
  State<LearnAirship> createState() => _LearnAirshipState();
}

class _LearnAirshipState extends State<LearnAirship> {
  changeTag(tags) async {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () async {
              final edit = Airship.editChannelTagGroups()
                ..setTags('school', ['student'])
                ..setTags('sex', ['male']);

              await edit.apply();
              logger.d(Airship.editChannelTagGroups().channel);
            },
            child: Text('student male')),
        ElevatedButton(
            onPressed: () {
              Airship.editChannelTagGroups()
                ..setTags('school', ['student'])
                ..setTags('sex', ['female'])
                ..apply();
            },
            child: Text('student female')),
        ElevatedButton(
            onPressed: () {
              Airship.editChannelTagGroups()
                ..setTags('school', ['parent'])
                ..setTags('sex', ['male'])
                ..apply();
            },
            child: Text('parent male')),
        ElevatedButton(
            onPressed: () {
              Airship.editChannelTagGroups()
                ..setTags('school', ['parent'])
                ..setTags('sex', ['female'])
                ..apply();
            },
            child: Text('parent female')),
      ]),
    );
  }
}
