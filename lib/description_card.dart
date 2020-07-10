import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'description.dart';

class DescriptionStorage {
  Future<String> readDescription() async {
    final String text =
        await rootBundle.loadString('assets/data/descriptionText.txt');
    return text;
  }
}

class DescriptionCards extends StatefulWidget {
  final DescriptionStorage storage;

  DescriptionCards({this.storage});

  @override
  _DescriptionCardsState createState() => new _DescriptionCardsState();
}

class _DescriptionCardsState extends State<DescriptionCards> {
  String text = "";
  @override
  void initState() {
    super.initState();
    widget.storage.readDescription().then((value) {
      setState(() {
        this.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Description> descriptions = [];
    if (this.text != "") {
      List<String> descriptionList = this.text.split("<new card>");
      for (int i = 0; i < descriptionList.length; i++) {
        descriptions.add(new Description(descriptionList[i]));
      }
    } else {
      setState(() {
        descriptions = <Description>[];
      });
    }
    return this.text == ""
        ? Container()
        : Container(
            child: Column(
              children: descriptions
                  .map((d) => EachCard(
                        description: d,
                      ))
                  .toList(),
            ),
          );
  }
}

class EachCard extends StatelessWidget {
  final Description description;

  EachCard({this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xC0FFFFFF),
        margin: EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description.contents,
                style: TextStyle(),
              ),
            ),
          ),
          description.table.length == 0
              ? Container()
              : TableCard(tableComponent: description.table),
        ]));
  }
}

class TableCard extends StatelessWidget {
  final List<TableComponent> tableComponent;

  TableCard({this.tableComponent});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
        child: Table(
          columnWidths: {0: FractionColumnWidth(.26)},
          children: tableComponent
              .map((t) => TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        t.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          t.contents,
                          style: TextStyle(),
                        ),
                      ),
                    )
                  ]))
              .toList(),
        ));
  }
}
