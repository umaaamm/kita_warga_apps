import 'package:bloc/bloc.dart';
import 'package:kita_warga_apps/bloc/app_states.dart';
import 'package:kita_warga_apps/model/general_response_post.dart';
import 'package:kita_warga_apps/model/warga/warga_delete_request.dart';
import 'package:kita_warga_apps/model/warga/warga_request.dart';
import 'package:kita_warga_apps/repository/warga_repository.dart';

class WargaBlocDelete extends Bloc<WargaDeleteRequest, AppServicesState> {
  final WargaRepository wargaRepository;
  WargaBlocDelete({required this.wargaRepository}) : super(InitialState()) {
    on<WargaDeleteRequest>((event, emit) async {
      emit(loadingServices());
      try {
        GeneralResponsePost response = await wargaRepository.deleteWarga(WargaDeleteRequest(event.id_warga));
        emit(successServices());
        return;
      } catch (e) {
        emit(errorServices(e.toString()));
      }
    });
  }
}
