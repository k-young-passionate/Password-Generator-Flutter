import 'package:flutter/material.dart';
import 'description.dart';

class DescriptionCards extends StatefulWidget {

  String text;
  DescriptionCards({this.text});

  @override
  _DescriptionCardsState createState() => _DescriptionCardsState(this.text);
}

class _DescriptionCardsState extends State<DescriptionCards> {
  List<Description> descriptions;
  String text = "";
  _DescriptionCardsState(String text) {
    print("12345678text: " + text);
    if (text != "") {
      print("text: \n" + text);
      setState(() {
        this.text = text;
        text.split("<new card>").map((d) {
          descriptions.add(new Description(d));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('+++++++++++++++');
    print("text: " + this.text);
    print('\n');
    print(this.descriptions);
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
        child: Column(children: [
      Text(
        description.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        description.contents,
        style: TextStyle(),
      ),
      description.table == null
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
    print("tableComponent\n=========================\n");
    print(tableComponent.join(" "));
    return Container();
    return Container(
        child: DataTable(
      columns: [
        DataColumn(label: Text('property')),
        DataColumn(label: Text('description'))
      ],
      rows: tableComponent
          .map((t) => DataRow(cells: [
                DataCell(
                  Text(
                    t.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataCell(
                  Text(
                    t.contents,
                    style: TextStyle(),
                  ),
                )
              ]))
          .toList(),
    ));
  }
}
