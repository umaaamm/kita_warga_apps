import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kita_warga_apps/bloc/get_dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard_last_trx.dart';
import 'package:kita_warga_apps/model/dashboard_last_trx_response.dart';
import 'package:kita_warga_apps/theme.dart';
import 'package:kita_warga_apps/utils/currency_format.dart';

class LastTransaction extends StatefulWidget {
  @override
  _LastTransactionState createState() => _LastTransactionState();
}

class _LastTransactionState extends State<LastTransaction> {
  @override
  void initState() {
    super.initState();
    dashboardLastTrxBloc..getDashboardLastTrx();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DashboardLastTrxResponse>(
      stream: dashboardLastTrxBloc.subject.stream,
      builder: (context, AsyncSnapshot<DashboardLastTrxResponse> snapshot) {
        if (!snapshot.hasData) {
          return _buildLoadingWidget();
        }

        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        }

        final list = snapshot.data!;
        if (list.error != null && list.error!.isNotEmpty) {
          return _buildErrorWidget(list.error.toString());
        }
        ;

        return _resultWidget(list);
      },
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
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _resultWidget(DashboardLastTrxResponse data) {
    List<DashboardLastTrx>? lastTrx = data.dashboardLastTrx;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 15),
          child: Text(
            'Fitur Aplikasi',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Pengeluaran',
                    style: blackTextStyle,
                  )
                ],
              ),
            ),
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    color: yellowColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Warga',
                    style: blackTextStyle,
                  )
                ],
              ),
            ),
            Container(
              height: 96,
              width: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Kas Bon',
                    style: blackTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 15),
          child: Text(
            'Transaksi Terakhir',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: whiteColor30,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.dashboardLastTrx.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/dummy/profile_picture.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lastTrx[index].nama,
                                style: regularTextStyle.copyWith(
                                    fontSize: 14, color: yellowColor),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(int.parse(lastTrx[index].balance), 0),
                                style: regularTextStyle.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: yellowColor),
                              ),

                              Text(
                                CurrencyFormat.convertDateEpoch(int.parse(lastTrx[index].tanggal)),
                                style: regularTextStyle.copyWith(
                                    fontSize: 12, color: yellowColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(
                          int.parse(lastTrx[index].keterangan) == 1 ? Icons.arrow_circle_down : Icons.arrow_circle_up,
                          color: int.parse(lastTrx[index].keterangan) == 1 ?  Colors.red : Colors.green,
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
