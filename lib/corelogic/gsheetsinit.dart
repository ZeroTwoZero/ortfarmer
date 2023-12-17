import 'package:gsheets/gsheets.dart';

const _credentials = r'''{
  "type": "service_account",
  "project_id": "isaeconvention",
  "private_key_id": "d19071684dad57ae5dd75f14d3f5507870dc8372",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4od7iePMqN+Z3\njt8+zlkJh2uIyHn7Kops/nfphB5m99uBhQLLgOS4zDhbyroeEpdaiH29Wi68yf9S\n/HQpC51ZNs/T4CRg5x8jkyqpKi3uDCBP8AZWWZSXITxG31OPhtW5VRRGVuOLAt33\nVA22B+xb0cCnfsClVxz4oBmHe2diVEnhtuwbKqYEDGO1WQkMLtuf2k4j9uogKImx\n9AMP5bOfLPSr8sP0JFDEW8Tz22L2n4fGWO7x44tjAf5HrPYFdomSOFxugSS+UU2C\nMi2o+g8FnC0p6+zGc7yAayEpJE6Ko9+yammShlRKB/LakOm4uYXk9r3palGojKRh\nHJeW+AAvAgMBAAECggEAJYljUw/cAB1VUcFOSeqR14ocprZ7dkDz26zwnB0sQSrr\nCa4NH2qZFakPXDofFLYa52EQj0qibedzbV++Dgo6d0TZg+3x93GFtynYZoQYymjU\nuOvHng6gUwmCw7XruyZilUdi09oecMiob/w6vWNm/lPqoyL176eCUFncVtsT7b10\nj1Z1I4x0C1NNzHNaeZjBi0OHpgKyxD6+uZvAJKZ4ZF/MO2WDA77m3FgGtCukKAwJ\nM+2hOs2OUBKDrhIBCnKqvQRq9HLUxgzDd9ZLvGkcRB4Z5NmUga/5Pk6HWqPKW20l\nvr41iVsz1JGE2hiFOfapdEN9rqoTKT1S40hdQDroIQKBgQDqoQt4OoPWk2ZreUls\nrlXFqqLjcobqo6FIfnygqH/+A7oRq4ZHP+4vxeESlXApGWDC8WE1GCtvhoey0XUm\n/Dfuf72T0CB26M+I4QqQaKuLUFbRPMX2h+JGIe6fSmyp9pHdPWyNx6uEZajdgI4T\n4iDscOXZi+iTqTdCiuM2J4KAOwKBgQDJcwchTEsOANasYnc6+X3gd53iP369LpHN\nrtiSH1XH2AGEBp2M5VxtyRZYD9RHZYDW0P5j176LCZMzPdoQbhUU9+eIRn/bsuSm\nVmtA+YISBInfwDLskyzN8EhKqqB9oOoZl5OkKJonvYjJqHPSyxH2d5VGFPYj/tzz\nJ9t0e9RUnQKBgAzqwM7lqcxuYP0ZuEkbb+1p733GGFdimsZ68DGIFUPOwLeoUcQq\naNqIclOrlnksxH72+vsJUZraNS5LCcATsqCWt8EjfCYPux02BnbczFTnH2B1kBB6\neqKRy6lJV6IjyPP9JbTIgVDQp/NJ2IiPsnBR5tWLNkqqzjgDnW6lzjFxAoGBALiw\nELVicN0hv67Dh3Q2EEWe5MzsUZG4BEyCJGOy/r39N0aHmiH2lcrBNQ7/VCswz/Ii\nIVgAD90ApkewSSAPDJzwuwChQc92L1KgoCwtlCZYqt7MIuPp+oXD6UMrM4B56qYT\n5XP3FX2hsqrPGYEEVC+WavCZfyB5JLB4tiYQ8RWxAoGAW9IEN3B/dUPee+vCzi46\nlY3ndxLWyzgfumF7+C2Rsc8jkbVi2TYwsaQNaAoHjITKc6oTtqQ3mLhOcxKTMh4Y\nCmzEc/vl3L/VwnbsANc/wpdIF/jDENrgUEHKfjTipH01ZzZCAhkH956+lf1ttgML\nbkZWVtnNB7dNrFXuAmsd2vg=\n-----END PRIVATE KEY-----\n",
  "client_email": "iseaserviceaccount@isaeconvention.iam.gserviceaccount.com",
  "client_id": "114341987073198045316",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/iseaserviceaccount%40isaeconvention.iam.gserviceaccount.com"
}''';
//spredsheet id
const _spreadsheetId = '1Q4SFFIU1f7atfjb2_O5up88ALR7O7xzLjbZetVlqOSw';
const _districtBlockspreadSheetId =
    '1uId63VXvbhPW5alrTy8UBhCky58vCmD5BqGdt6NhEio';
Spreadsheet? spreadsheet, spreadsheet1;

Future initializeGSheets() async {
  var gsheets = GSheets(_credentials);
  spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
  spreadsheet1 = await gsheets.spreadsheet(_districtBlockspreadSheetId);
}

Future<List<String>> getNamesOfMLTTypes() async {
  List<String> sheetNames = [];
  if (spreadsheet != null) {
    await spreadsheet!.refresh();
    int id = 0;
    var workSheet = spreadsheet!.worksheetByIndex(id);
    while (workSheet != null) {
      sheetNames.add(workSheet.title);
      id++;
      workSheet = spreadsheet!.worksheetByIndex(id);
    }
  }
  return sheetNames;
}

Future<List<String>> getNamesOfMLT(String title) async {
  List<String> namesOfMLT = [];
  if (spreadsheet != null) {
    await spreadsheet!.refresh();
    var workSheet = spreadsheet!.worksheetByTitle(title);
    if (workSheet != null) {
      var recordOfMLT = await workSheet.values.allRows(fromRow: 2);
      for (var mlt in recordOfMLT) {
        if (mlt.isNotEmpty) {
          namesOfMLT.add(mlt[2]);
        }
      }
    }
  }
  return namesOfMLT;
}

Future<List<String>> getDistrict() async {
  List<String> sheetNames = [];
  if (spreadsheet1 != null) {
    await spreadsheet1!.refresh();
    int id = 0;
    var workSheet = spreadsheet1!.worksheetByIndex(id);
    while (workSheet != null) {
      sheetNames.add(workSheet.title);
      id++;
      workSheet = spreadsheet1!.worksheetByIndex(id);
    }
  }
  return sheetNames;
}

Future<List<String>> getBlock(String title) async {
  List<String> blocks = [];
  if (spreadsheet1 != null) {
    await spreadsheet1!.refresh();
    var workSheet = spreadsheet1!.worksheetByTitle(title);
    if (workSheet != null) {
      var blockList = await workSheet.values.allRows();
      for (var block in blockList) {
        if (block.isNotEmpty) {
          blocks.add(block[0]);
        }
      }
    }
  }
  return blocks;
}
