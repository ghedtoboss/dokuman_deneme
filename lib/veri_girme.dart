import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getx_tutorial/sizes_helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../services/status_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GozlemPage extends StatefulWidget {
  const GozlemPage({Key? key}) : super(key: key);

  @override
  State<GozlemPage> createState() => _GozlemPageState();
}

class _GozlemPageState extends State<GozlemPage> {
  StatusService _statusService = StatusService();
  TextEditingController statusController = TextEditingController();

  bool _isSelectedC1 = false;
  bool _isSelectedC2 = false;
  List<String> _durumlar = [
    'Kenar koruma',
    'Yükselte çalışma',
    'Elektrik',
    'Basınçlı gaz tüpleri',
    'İskele, merdiven ve çalışma platformları',
    'Kazı-hafriyat',
    'Vinçle kaldırma operasyonları',
    'Tertip-düzen',
    'Sıcak çalışmalar',
    'İş makineleri',
    'Kimyasallar(Depolama,kullanım,bertaraf)',
    'Gürültü',
    'El aletleri',
    'Toz',
    'Aydınlatma',
    'Çevreye zarar',
    'Olumsuz hava koşulları',
    'Yangın önlemleri',
    'Düşen nesneler',
    'Enerji izolasyonu',
    'El ile taşıma ve kaldırma',
    'Kapalı kısıtlı alan çalışması',
    'Kişisel koruyucu donanım',
    'Diğer(açıklayın)'
  ];
  String? _secilenDurum = "Kenar koruma";
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController textController4 = TextEditingController();
  final TextEditingController textController5 = TextEditingController();
  TimeOfDay? time = const TimeOfDay(hour: 24, minute: 12);

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var profileImage;

  String? _selectedTime;
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _firestore.collection('Çalışanlar');
    var raporRef = _firestore.collection('Raporlar');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF323B45),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(children: [
          Container(
            width: displayWidth(context),
            height: displayHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFD67C53)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(45, 10, 0, 0),
                        child: Container(
                          child: ChoiceChip(
                            label: Text('Güvensiz durum'),
                            selected: _isSelectedC1,
                            onSelected: (newboolvalue) {
                              setState(() {
                                _isSelectedC1 = newboolvalue;
                                if (_isSelectedC2 = true) {
                                  _isSelectedC2 = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 45, 0),
                        child: Container(
                          child: ChoiceChip(
                            label: Text('Güvensiz davranış'),
                            selected: _isSelectedC2,
                            onSelected: (newboolvalue) {
                              setState(() {
                                _isSelectedC2 = newboolvalue;
                                if (_isSelectedC1 = true) {
                                  _isSelectedC1 = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: CustomDropdownButton2(
                          buttonWidth: 300,
                          dropdownWidth:
                              MediaQuery.of(context).size.width / 1.05,
                          scrollbarAlwaysShow: true,
                          dropdownDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFF0B0614)),
                              borderRadius: BorderRadius.circular(10)),
                          buttonDecoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF0B0614), width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          hint: 'Select Item',
                          dropdownItems: _durumlar,
                          value: _secilenDurum,
                          onChanged: (value) {
                            setState(() {
                              _secilenDurum = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: TextFormField(
                          controller: textController1,
                          onFieldSubmitted: (_) async {
                            if ((_secilenDurum) == 'Diğer') {
                              return;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Diğer',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00666262),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00666262),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Color(0xB7FFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                          ),
                          style: GoogleFonts.getFont(
                            'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 0.4,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          //new buttonText starts
                          child: Container(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 50, 59, 61)),
                              label: Text(
                                'Tarih seçiniz',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2000, 3, 5),
                                    maxTime: DateTime(2090, 6, 7),
                                    theme: DatePickerTheme(
                                        headerColor: Colors.grey,
                                        backgroundColor:
                                            Color.fromARGB(255, 50, 59, 61),
                                        itemStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16)), onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.tr);
                              },
                            ),
                          )
                          //new buttonText ends.
                          ),
                    ),
                    Expanded(
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: Container(
                              child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 50, 59, 61)),
                            label: Text(
                              'Saat Giriniz',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            icon: Icon(Icons.access_time),
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time!);
                              if (newTime != null) {
                                setState(() {
                                  time = newTime;
                                });
                              }
                            },
                          ))),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: TextFormField(
                          controller: textController2,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Konumu Giriniz*",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 2)),
                            filled: true,
                            fillColor: Color(0xB7FFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                          ),
                          style: GoogleFonts.getFont(
                            'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 0.4,
                          ),
                          maxLines: 2,
                          keyboardType: TextInputType.streetAddress,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: TextFormField(
                          controller: textController3,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Gözlem Açıklaması*",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 2)),
                            filled: true,
                            fillColor: Color(0xB7FFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                          ),
                          style: GoogleFonts.getFont(
                            'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.3,
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.streetAddress,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: TextFormField(
                          controller: textController4,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "adınız ve soyadınız*",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 2)),
                            filled: true,
                            fillColor: Color(0xB7FFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                          ),
                          style: GoogleFonts.getFont(
                            'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 0.5,
                          ),
                          maxLines: 2,
                          keyboardType: TextInputType.streetAddress,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: TextFormField(
                          controller: textController5,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Öneri Giriniz",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x00666262), width: 2)),
                            filled: true,
                            fillColor: Color(0xB7FFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                          ),
                          style: GoogleFonts.getFont(
                            'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.3,
                          ),
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        //new buttonText starts
                        child: Container(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 50, 59, 61)),
                            label: Text(
                              'Kamerayı aç',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            icon: Icon(Icons.photo_camera),
                            onPressed: () {
                              _onImageButtonPressed(
                                  ImageSource.camera, // camera tıklayınca açma
                                  context: context);
                            },
                          ),
                        )
                        //new buttonText ends.
                        ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: Container(
                            child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 50, 59, 61)),
                          label: Text(
                            'Galeriyi aç',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          icon: Icon(Icons.image),
                          onPressed: () {
                            _onImageButtonPressed(
                                ImageSource.gallery, //galeri tıklayınca açma
                                context: context);
                          },
                        ))),
                  )
                ]),
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 50, 59, 61)),
                              label: Text(
                                'Gönder',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(Icons.send_rounded),
                              onPressed: () async {
                                Map<String, dynamic> raporData = {
                                  'Ad soyad': textController4.text,
                                  'Gözlem açıklaması': textController3.text,
                                  'Konum': textController2.text,
                                  'Sınıf': _secilenDurum.toString(),
                                  'Tarih': DateTime.now(),
                                  'Öneri': textController5.text,
                                };
                                String currentUserId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                _firestore
                                    .collection('Çalışanlar')
                                    .doc(currentUserId)
                                    .collection("rapor")
                                    .add(raporData);
                              })),
                    ),
                  )
                ])
              ]),
        ])),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("dosyaya geldim: $profileImage");
        if (profileImage != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }
}
