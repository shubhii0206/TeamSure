import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class Product {
  String workType;
  String amount;
  String id;
  Map work;
  Product(
      {@required this.workType,
      @required this.amount,
      @required this.id,
      @required this.work});
}

class DatabaseServices {
  String collectionName;
  List<Product> inventory = [];

  DatabaseServices({@required this.collectionName});

  Future<List<Product>> getInventoryData() async {
    print('Inside getInventory Data');
    await Firestore.instance
        .collection(collectionName)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((item) {
        inventory.add(Product(
          workType: item.data['Type of work'],
          amount: item.data['Amount'],
          id: item.documentID,
          work: item.data,
        ));
      });
    });
    print('Inventory');
    print(inventory);
    return inventory;
  }

  // getProductDescription(String name) async {
  //   // Map<String, String> prod_description;
  //   await Firestore.instance
  //       .collection(collectionName)
  //       .document(name)
  //       .get()
  //       .then((value) {
  //     return (value == null)
  //         ? null
  //         : {
  //             'About': value?.data['About'],
  //             'Storage': value?.data['Storage'],
  //             'Benefits': value?.data['Benefits']
  //           };
  //   });
  // }
}
