import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class LearnAem extends StatefulWidget {
  const LearnAem({super.key});

  @override
  State<LearnAem> createState() => _LearnAemState();
}

class _LearnAemState extends State<LearnAem> {
  Map<String, dynamic>? allData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    (() async {
      final dio = Dio();
      final res = await dio.get(
          'https://publish-p108487-e1076544.adobeaemcloud.com/content/wknd/poc.model.json');
      setState(() {
        allData = res.data;

        // logger.d(
        //     'https://publish-p108487-e1076544.adobeaemcloud.com${res.data?[':items']['root'][':items']['container'][':items']['image']['src'] ?? ''}');
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
            'https://publish-p108487-e1076544.adobeaemcloud.com${allData?[':items']['root'][':items']['container'][':items']['image']['src'] ?? ''}'),
        Text(allData?[':items']['root'][':items']['container'][':items']
                ['title']['text'] ??
            ''),
        Text(allData?[':items']['root'][':items']['container'][':items']['text']
                ['text'] ??
            ''),
      ],
    );
  }
}
