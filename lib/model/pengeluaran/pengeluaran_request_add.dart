import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


@immutable
abstract class StatePengeluaran extends Equatable {
  const StatePengeluaran();
}


class PengeluaranRequestAdd extends StatePengeluaran {
  final String id_transaksi;
  final String nama_transaksi;
  final String id_kategori;
  final String id_kasbon;
  final String kategori_transaksi;
  final String tanggal_transaksi;
  final String nilai_transaksi;
  final String keterangan;
  final String bukti_foto;

  PengeluaranRequestAdd(this.id_transaksi,
      this.nama_transaksi,
      this.id_kategori,
      this.id_kasbon,
      this.kategori_transaksi,
      this.tanggal_transaksi,
      this.nilai_transaksi,
      this.keterangan,
      this.bukti_foto);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}