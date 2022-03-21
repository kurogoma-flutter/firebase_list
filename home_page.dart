import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Section2 extends StatefulWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  _Section2State createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  // 格納するユーザーデータ
  List<DocumentSnapshot> userList = [];

  _getUserData() async {
    // 指定コレクションのドキュメント一覧を取得
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    // ドキュメント一覧を配列で格納
    setState(() {
      userList = snapshot.docs;
    });
  }

  // 初期化メソッドでリストを取得する
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Section2'),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Mapにしてリスト表示をする
          children: userList.map((document) {
            return Container(
              width: size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54, width: 2.0),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1.0,
                    blurRadius: 5.0,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const CircleAvatar(),
                  Row(
                    children: [
                      Text('id: ${document['id'].toString()}'),
                      const SizedBox(width: 20),
                      Text('name: ${document['name']}'),
                      const SizedBox(width: 20),
                      Text('age: ${document['age'].toString()}')
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
