import 'dart:convert';

class Description {
  String title = "";
  String contents = "";
  List<TableComponent> table = [];

  Description(String getText) {
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(getText);
    int status = 0;
    for (int i = 0; i < lines.length; i++) {
      switch (status) {
        case 0: // title case
          if (lines[i].contains("<contents>")) {
            // to contents case
            status = 1;
          } else {
            title += (lines[i] + "\n");
          }
          break;
        case 1: // contents case
          if (lines[i].contains("<tables>")) {
            // to table case
            status = 2;
          } else {
            contents += (lines[i] + "\n");
          }
          break;
        case 2: // table case
          String tableTitle = "";
          String tableContents = "";
          int tableStatus = -1;
          while (true) {
            print(i);
            print("\n");
            print(lines[i]);
            if (lines[i].contains("</tr>") || i == lines.length) {
              table.add(TableComponent(title: tableTitle, contents: tableContents));
              break;
            } else if (lines[i].contains("<th>")) {
              tableStatus = 0;
              i++;
              continue;
            } else if (lines[i].contains("<td>")) {
              tableStatus = 1;
              i++;
              continue;
            }

            switch (tableStatus) {
              case 0:  // table title case
                tableTitle += lines[i];
                break;
              case 1:  // table contents case
                tableContents += lines[i];
                break;
              default:
                // do nothing
                break;
            }
            i++;
          }
          break;
        default:
          // do nothing
          break;
      }
    }
  }
}

class TableComponent {
  String title = "";
  String contents = "";

  TableComponent({this.title, this.contents});
}
