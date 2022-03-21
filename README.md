# firebase_list
Firebaseにあるデータを一覧表示する

## 動作結果
### Firestoreの構造
<img width="600" alt="section2" src="https://user-images.githubusercontent.com/67848399/159211853-bbc1ab78-6e39-43e9-85c7-50b2a95bd1bb.png">

### 画面
<img width="300" alt="section2" src="https://user-images.githubusercontent.com/67848399/159211956-43217ff9-17d4-4108-a36e-e59592697adf.png">

## 処理部分
一覧を取得する処理
```dart
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
```
Map表示してリストを呼び出す
```dart
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
        // Mapで記述することで配列的な感じで呼び出せる
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
```
