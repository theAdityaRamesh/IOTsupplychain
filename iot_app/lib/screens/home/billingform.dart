import 'package:flutter/material.dart';
import 'package:iot_app/models/goods.dart';
import 'package:provider/provider.dart';
import 'package:iot_app/services/database.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class Billing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Goods>>.value(
      value: DatabaseService().goods,
      child: Scaffold(

        body : BillingPage(),
      ),
    );
  }
}

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _adv;
  String _pm;
  String _delayr;
  double _output=0.0;
  double ad = 0.0;
  double damage = 0.0;
  double delayr = 0.0;
  String _dist;
  double distr;

  var rfid = List();
  var countl = List();
  int lcount=0;
  String _rfs;
  double delay=0.0;
  double totaldist=0.0;
  int count = 0;
  int rf=1;
  int tol = 100;



  @override
  Widget build(BuildContext context) {
    final goods = Provider.of<List<Goods>>(context);
    rfid.clear();
    countl.clear();
    //print(goods.documents);
    goods.forEach((good){
      count=0;
      for(var i=0; i < good.temp.length;i++){
        if (good.temp[i]>30.0){
          count=count+1;
        }
      }
      for (var i=0; i < good.humidity.length;i++){
        if (good.humidity[i]>30.0){
          count=count+1;
        }
      }

      print(good.rfid);
      rfid.add(good.rfid);
      countl.add(count);
      print(good.status);
      print(good.temp);
      print(good.humidity);
      print(good.location);
    });
    print(goods);
    print(countl);
    rf=rfid[0];
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text('Generate Bills', style: TextStyle(fontFamily: 'Play'),),
          backgroundColor: Color.fromRGBO(52, 73, 94, 1),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/bill.png'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(labelText: 'Advance Amount'),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    onChanged: (val){
                      setState(() => _adv=val);
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(labelText: 'Penalty for deviation '),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    onChanged: (val){
                      setState(() => _pm=val);
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(labelText: 'Penalty per day delay'),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    onChanged: (val){
                      setState(() => _delayr=val);
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(labelText: 'Cost per KM'),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    onChanged: (val){
                      setState(() => _dist=val);
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(labelText: 'RFID'),
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                    onChanged: (val){
                      setState(() => _rfs=val);
                    },
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  new RaisedButton(
                    color: Colors.teal,
                    onPressed: ()async{
                      ad = double.parse(_adv);
                      damage = double.parse(_pm);
                      delayr = double.parse(_delayr);
                      rf = int.parse(_rfs);
                      distr = double.parse(_dist);
                      for(var i=0; i < rfid.length;i++){
                        if(rf==rfid[i]){
                          lcount=countl[i];
                        }
                      }
                      print(lcount.toString());
                      _output=distr*tol-lcount*damage-delayr*delay+0.12*(distr*tol-lcount*damage-delayr*delay);
                      print(_output.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bill(out:_output.toString(),adv:_adv, delay:_delayr, dist:_dist, damage:_pm, lcount:lcount.toString() )),
                      );
                    },
                    child: new Text('Submit', style:TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class Bill extends StatelessWidget {
  final String out;
  final String adv;
  final String delay;
  final String dist;
  final String damage;
  final String lcount;
  final pdf = pw.Document();

  writeOnPdf(){
    pdf.addPage(
        pw.MultiPage(
            pageFormat:
            PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm,marginLeft: 1.5 * PdfPageFormat.cm,marginRight: 1.5 * PdfPageFormat.cm,marginTop: 1.5 * PdfPageFormat.cm),
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            header: (pw.Context context) {
              if (context.pageNumber == 1) {
                return null;
              }
              return pw.Container(
                  alignment: pw.Alignment.topLeft,
                  margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
                  padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
                  decoration: const pw.BoxDecoration(
                      border:
                      pw.BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
                  child: pw.Text('TallyAssist',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey)));
            },
            footer: (pw.Context context) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('Generated by 24GoAT Technology',
                          style: pw.TextStyle(
                              color: PdfColors.purple400, font: pw.Font.timesItalic())),
                      pw.Text('Page 1 of 1',
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                              .copyWith(color: PdfColors.grey))
                    ]),
              );
            },
            build: (pw.Context context) => <pw.Widget>[
              pw.Header(
                level: 0,
                child: pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.BoxBorder(
                      bottom: true,
                      top: true,
                    ),
                  ),
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,

                      children: <pw.Widget>[

                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [

                            pw.Text('24 GoAT',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.indigo900,
                                  fontSize: 40,

                                )),
                            pw.Text(" "),
                            pw.Text('630, Gnan Marg, Sri City, Sathyavedu, Andhra Pradesh, 517646'),

                            pw.Text('Ph No: +91 9923134320'),
                            pw.Text('GSTIN: ABCD123456SDS')
                          ],
                        ),

                      ]),
                ),
              ),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Container(
                      margin: pw.EdgeInsets.all(20),
                      child: pw.Table(
                        columnWidths: {
                          0: pw.FractionColumnWidth(0.7),
                          1: pw.FractionColumnWidth(0.3)
                        },
                        border: pw.TableBorder(bottom: true),
                        children: [
                          pw.TableRow(decoration: pw.BoxDecoration(color: PdfColors.indigo900 ),
                              children: [
                                pw.Text('  Services', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 20)),
                                pw.Text('  Charges', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white,  fontSize: 20)),
                              ]),

                          pw.TableRow(children: [
                            pw.Text('  Cost Per Km', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $dist', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),

                          pw.TableRow(children: [
                            pw.Text('  Delay', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  2 Days', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  Penality for delay per day', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $delay', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  Total Deviation', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $lcount', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  Penality for each deviation', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $damage', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  GST', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  12%', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  Total Amount', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $out', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(children: [
                            pw.Text('  Advance Paid', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                            pw.Text('  $adv', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                          ]),
                          pw.TableRow(decoration: pw.BoxDecoration(color: PdfColors.blue50 ),
                              children: [
                                pw.Text('  Amount to be paid', textAlign: pw.TextAlign.center , style:pw.TextStyle(fontSize: 20)),
                                pw.Text('  ${(double.parse(out)-double.parse(adv)).toStringAsFixed(2)}', textAlign: pw.TextAlign.center, style:pw.TextStyle(fontSize: 20)),
                              ]),
                        ],
                      ),
                    ),
                  ]),
            ]));
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/bill.pdf");
    file.writeAsBytesSync(pdf.save());
  }

  Bill({Key key, @required this.out, @required this.adv, @required this.delay, @required this.dist,@required this.damage,@required this.lcount }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bill',style: TextStyle(fontFamily: 'Play'),),
      backgroundColor: Color.fromRGBO(52, 73, 94, 1),),
      body: Center(
        child: new Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Image(
                image: AssetImage('assets/bill2.png'),
              ),
              SizedBox(height: 20,),
              Text("Advance Paid:             $adv",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Delay Cost:                      $delay",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Delay:                         2 days",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Distance:               100kms",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Cost per KM:                 $dist",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Deviation Penalty:      $damage",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Total deviation:              $lcount",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("GST :                              12%",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 10,),
              Text("Total:                      ${double.parse(out) - double.parse(adv)}",
                style: TextStyle(fontSize: 24, fontFamily: 'Play'),
              ),
              SizedBox(height: 30,),
              new RaisedButton(
                onPressed: ()async{
                  writeOnPdf();
                  await savePdf();
                  Directory documentDirectory = await getApplicationDocumentsDirectory();
                  String documentPath = documentDirectory.path;
                  String fullPath = "$documentPath/bill.pdf";
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>PdfPreviewScreen(path: fullPath,)));
                },
                child: Text('Download Bill', style: TextStyle(color: Colors.white),),
                color: Colors.teal,
              ),
            ]
        ),
      ),
    );
  }
}

class PdfPreviewScreen extends StatelessWidget {
  final String path;
  PdfPreviewScreen({this.path});
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  } //Ok na?
}