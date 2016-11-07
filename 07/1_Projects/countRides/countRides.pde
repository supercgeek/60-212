Table allRidesTable;


void setup() {
  allRidesTable = loadTable("2015Q3.csv", "header");
  // Trip id, Starttime, Stoptime, Bikeid, Tripduration, From station id, From station name, To station id, To station name, Usertype
  int nRows = allRidesTable.getRowCount(); 

  for (int i = 0; i<nRows; i++) {
    TableRow ithRow = allRidesTable.getRow(i);
    int id =ithRow.getInt("Trip id");//this is the name of the header row thing
    String ithFromStationName = ithRow.getString("From station name");
    println(i + "\t" + ithFromStationName);
  }
}