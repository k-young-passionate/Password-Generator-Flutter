import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'description.dart';

class DescriptionStorage {
  Future<String> readDescription() async {
    final String text =
        await rootBundle.loadString('assets/data/description.txt');
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
  String text = """
Description: What is this site for?
<contents>
Convert your "Hacking easy password" into the password that hard to remember IN YOUR COMPUTER.
There is NO TRANSMISSION OF YOUR PASSWORD in this site.
<new card>
How to Use?
<contents>
If you just fill in the 3 spaces, then you will get a STRONG password. 
You can get the same password forever with the same 3 spaces' values. 
Space's value explanation is in the next line.  
<tables>
<th>
Password
<td>
Fill your password that you are usually using.
</tr>
<th>
Easy words
<td>
Fill any easy word that can be varied with web pages.
example) GolfGame (in Google), FreshFruit (in Facebook) 
</tr>
<th>
Length
<td>
There might be a site that sets the password length limitation.
You can set the length of a new password. 
If you set it less than 1, the length limit will not be applied.					
</tr>
<th>
Special Characters
<td>
You can choose to include special characters on a new password or not.					
</tr>
<new card>
What are the expectations?
<contents>
1. You can get a strong password with easy memorization. You can get the same one on this page. 
2. If you stole a password for one of the web sites, your other password would be safe. 
3. If one of your passwords has been exposed to someone for a moment, it's not easy to remember so that
your password might be safe.
<new card>
Keep in Mind!
<contents>
Do not expose your "Easywords" and especially "Password." 
If those things are exposed, your strong passwords will become very weak.
  """;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.storage.readDescription().then((value) {
  //     setState(() {
  //       this.text = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Description> descriptions = [];
    // if (this.text != "") {
    List<String> descriptionList = this.text.split("<new card>");
    for(int i=0; i<descriptionList.length; i++){
      print(i);
      print('\n');
      print(descriptionList[i]);
      descriptions.add(new Description(descriptionList[i]));
    }
    // } else {
    //   setState(() {
    //     this.descriptions = <Description>[];
    //   });
    // }
    print(descriptions);
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
