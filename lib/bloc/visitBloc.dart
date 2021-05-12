import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart' as base;
import 'package:oro_task/model/visits.dart';

enum VisitEvents {
  Request,
  Cancel,
}

class VisitBloc extends base.BlocBase {
  Visits newVisit;

  final StreamController<Visits> _newVisit =
      StreamController<Visits>.broadcast();

  final StreamController<List<Visits>> _visitBloc =
      StreamController<List<Visits>>.broadcast();

  final StreamController<VisitEvents> _visitEventBloc =
      StreamController<VisitEvents>.broadcast();

  StreamSink<VisitEvents> get visitsSink => _visitEventBloc.sink;
  Stream<List<Visits>> get visitsStream => _visitBloc.stream;
  Stream<Visits> get newVisitsStream => _newVisit.stream;

  void initialise(Map<String, dynamic> e) {
    newVisit.addressMap = e;
    _newVisit.sink.add(newVisit);
  }

  void initialiseMainData(DateTime dt, int status, int id) {
    newVisit.timestamp = Timestamp.fromDate(dt);
    newVisit.id = id;
    newVisit.status = status;
    _newVisit.sink.add(newVisit);
  }

  VisitBloc() {
    fetchData();
    newVisit = Visits(id: null, timestamp: null, status: null);
    _visitEventBloc.stream.listen((event) {
      switch (event) {
        case VisitEvents.Request:
          Map<String, dynamic> tempMap = newVisit.addressMap;
          tempMap.putIfAbsent("time", () => newVisit.timestamp);
          tempMap.putIfAbsent("status", () => newVisit.status);
          tempMap.putIfAbsent("id", () => newVisit.id);
          FirebaseFirestore.instance.collection("visits").add(tempMap);
          break;
        case VisitEvents.Cancel:
          break;
        default:
      }
    });
  }
  void fetchData() {
    FirebaseFirestore.instance.collection("visits").snapshots().listen((event) {
      _visitBloc.sink.add(event.docs.map((e) {
        return Visits(
          id: e.data()["id"],
          timestamp: e.data()["time"],
          status: e.data()["status"],
          addressMap: e.data(),
        );
      }).toList());
    });
  }

  Future<void> updateData(int id) async {
    QuerySnapshot ds = await FirebaseFirestore.instance
        .collection("visits")
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    ds.docs.first.reference.update({"status": 2});
  }

  @override
  void dispose() {
    _visitBloc.close();
    _newVisit.close();
    _visitEventBloc.close();
  }
}
