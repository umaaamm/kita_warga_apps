import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/bloc/bloc_shared_preference.dart';
import 'package:kita_warga_apps/bloc/warga/warga_bloc.dart';
import 'package:kita_warga_apps/components/dropdown_component.dart';
import 'package:kita_warga_apps/components/rounded_button.dart';
import 'package:kita_warga_apps/components/switch_button.dart';
import 'package:kita_warga_apps/components/text_input_border_bottom.dart';
import 'package:kita_warga_apps/model/warga/list_warga.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';
import 'package:kita_warga_apps/pages/warga/title_warga.dart';
import 'package:kita_warga_apps/pages/warga/warga_pages.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:uuid/uuid.dart';

class EditWargaPages extends StatefulWidget {
  final ListWarga listWarga;
  EditWargaPages({super.key, required this.listWarga});

  @override
  State<EditWargaPages> createState() => _EditWargaPagesState();
}

class _EditWargaPagesState extends State<EditWargaPages> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerNoHome = TextEditingController();
  final TextEditingController _controllerNoBlok = TextEditingController();
  final TextEditingController _controllerNoRt = TextEditingController();
  final TextEditingController _controllerNoRw = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.listWarga.nama_warga;
    _controllerEmail.text = widget.listWarga.email;
    _controllerPhone.text = widget.listWarga.nomor_hp;
    _controllerNoHome.text = widget.listWarga.nomor_rumah;
    _controllerNoBlok.text = widget.listWarga.blok_rumah;
    _controllerNoRt.text = widget.listWarga.id_rt;
    _controllerNoRw.text = widget.listWarga.id_rw;
    dropdownValue = widget.listWarga.jenis_kelamin;
    dropdownValueKawin = widget.listWarga.status_pernikahan;
  }

  static const List<String> list = <String>[
    'Pilih Salah Satu',
    'Laki-Laki',
    'Perempuan'
  ];
  static const List<String> listKawin = <String>[
    'Pilih Salah Satu',
    'Nikah',
    'Lajang',
    'Duda',
    'Janda'
  ];
  String dropdownValue = list.first;
  String dropdownValueKawin = listKawin.first;
  bool is_rw = false, is_rt = false;

  bool checkValueRT = false;
  bool checkValueRW = false;
  var uuid = Uuid();
  String id_warga = "",
      nama_warga = "",
      blok_rumah = "",
      nomor_rumah = "",
      email = "",
      nomor_hp = "",
      id_rt = "",
      id_rw = "",
      id_perumahan = "",
      status_pernikahan = "",
      jenis_kelamin = "";

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return RepositoryProvider(
      create: (context) => WargaRepository(),
      child: BlocProvider(
        create: (context) => WargaBloc(
            wargaRepository: RepositoryProvider.of<WargaRepository>(context)),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const title_warga(
                  Title: "Edit Data Warga",
                  SubTitle: "Silahkan edit data warga anda",
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                TextInputBorderBottom(
                  controllerText: _controller,
                  labelText: "Nama Warga",
                  hintText: "Masukkan nama warga",
                  onChanged: (value) {
                    setState(
                      () {
                        _controller.text = value;
                      },
                    );
                  },
                ),
                dropdownCustom(
                  textHint: "Status Perkawinan",
                  title: "Pilih salah status perkawinan",
                  onChanged: (value) {
                    setState(() {
                      dropdownValueKawin = value!;
                      status_pernikahan = value;
                    });
                  },
                  dropdownValue: dropdownValueKawin,
                  list: listKawin,
                ),
                dropdownCustom(
                    textHint: "Jenis Kelamin",
                    title: "Pilih Jenis Kelamin",
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                        jenis_kelamin = value;
                      });
                    },
                    dropdownValue: dropdownValue,
                    list: list),
                TextInputBorderBottom(
                    labelText: "Email",
                    controllerText: _controllerEmail,
                    hintText: "Masukkan email warga",
                    onChanged: (value) {
                      _controllerEmail.text = value;
                    }),
                TextInputBorderBottom(
                    labelText: "No Handphone",
                    controllerText: _controllerPhone,
                    hintText: "Masukkan nomor handphone",
                    onChanged: (value) {
                      _controllerPhone.text = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor Rumah",
                    controllerText: _controllerNoHome,
                    hintText: "Masukkan Nomor rumah",
                    onChanged: (value) {
                      _controllerNoHome.text = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Blok Rumah",
                    controllerText: _controllerNoBlok,
                    hintText: "Masukkan blok rumah warga",
                    onChanged: (value) {
                      _controllerNoBlok.text = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor RT",
                    controllerText: _controllerNoRt,
                    hintText: "Masukkan Nomor RT",
                    onChanged: (value) {
                      _controllerNoRt.text = value;
                    }),
                TextInputBorderBottom(
                    labelText: "Nomor RW",
                    controllerText: _controllerNoRw,
                    hintText: "Masukkan Nomor RW",
                    onChanged: (value) {
                      _controllerNoRw.text = value;
                    }),
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RT",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRT = value!;
                      is_rt = value!;
                    });
                  },
                  checkValue: checkValueRT,
                ),
                SwitchButton(
                  title: "Apakah Warga Menjadi Ketua RW",
                  toggleSwitchState: (value) {
                    setState(() {
                      checkValueRW = value!;
                      is_rw = value!;
                    });
                  },
                  checkValue: checkValueRW,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    key: scaffoldKey,
                    child: BlocListener<WargaBloc, AppServicesState>(
                      listener: (context, state) {
                        if (state is successServices) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return WargaPages();
                              },
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: BlocBuilder<WargaBloc, AppServicesState>(
                        builder: (context, state) {
                          print(state);
                          if (state is loadingServices) {
                            return _buildLoadingWidget();
                          } else if (state is errorServices) {
                            return const Center(child: Text("Error"));
                          }
                          return RoundedButton(
                            text: "Simpan",
                            onPressed: () {
                              _postData(context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(blueColor),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  void Snack(String text) {
    final snackBar = SnackBar(
      content: Text(text,
          style:
              regularTextStyle.copyWith(fontSize: 16.sp, color: Colors.white)),
      backgroundColor: Colors.red,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  void _postData(context) async {
    BlockPreference blockPreference = BlockPreference();
    await blockPreference.getDataAccount();

    if (_controller.text.isEmpty) {
      return Snack("Nama Warga tidak boleh kosong.");
    }
    if (_controllerNoBlok.text.isEmpty) {
      return Snack("Blok Rumah tidak boleh kosong.");
    }
    if (_controllerNoHome.text.isEmpty) {
      return Snack("Nomor Rumah tidak boleh kosong.");
    }
    if (!EmailValidator.validate(_controllerEmail.text)) {
      return Snack("Email tidak sesuai.");
    }
    if (_controllerPhone.text.isEmpty) {
      return Snack("Nomor HP tidak boleh kosong.");
    }
    if (status_pernikahan.isEmpty && dropdownValueKawin.isEmpty) {
      return Snack("Status Pernikahan tidak boleh kosong.");
    }
    if (jenis_kelamin.isEmpty && dropdownValue.isEmpty) {
      return Snack("Jenis Kelamin tidak boleh kosong.");
    }
    if (_controllerNoRw.text.isEmpty) {
      return Snack("RT tidak boleh kosong.");
    }
    if (_controllerNoRt.text.isEmpty) {
      return Snack("RT tidak boleh kosong.");
    }

    BlocProvider.of<WargaBloc>(context).add(
      WargaRequest(
          uuid.v1(),
          nama_warga,
          blok_rumah,
          nomor_rumah,
          email,
          nomor_hp,
          is_rw,
          is_rt,
          id_rw,
          id_rt,
          blockPreference.idPerumahan ?? "",
          status_pernikahan,
          jenis_kelamin),
    );
  }
}
