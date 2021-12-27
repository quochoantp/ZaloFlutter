import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class AlphabetScrollPage extends StatefulWidget {
  final List<String> items;
  const AlphabetScrollPage({Key? key, required this.items}) : super(key: key);

  @override
  _AlphabetScrollPageState createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<_AzItem> items = [];
  @override
  void initState(){
    super.initState();
    initList(widget.items);
  }
  @override
  Widget build(BuildContext context) {
    return AzListView(
      padding: EdgeInsets.all(20),
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index){
        final item = items[index];

        return _buildListItem(item);
      },
    );
  }

  Widget _buildListItem(_AzItem item){
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;
    return Column(
      children: [
        Offstage(offstage: offstage, child: buildHeader(tag)),
        ListTile(
            leading: CircleAvatar(
              child: Text(
                  tag),
            ),
            title: Text(item.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.phone_outlined), onPressed: () {  },),
                IconButton(icon: Icon(Icons.video_call_outlined), onPressed: () {  },),
              ],
            )
        ),
      ],
    );
  }

  void initList(List<String> items) {
    this.items = items.map((item) => _AzItem(title: item, tag: item[0].toUpperCase())).toList();
    SuspensionUtil.setShowSuspensionStatus(this.items);
  }

  Widget buildHeader(String tag) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Colors.black12,
              width: 1.0
            )
          )
      ),
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
  
}

class _AzItem extends ISuspensionBean {
  final String title;
  final String tag;
  _AzItem({
    required this.title,
    required this.tag
  });
  @override
  String getSuspensionTag() {
    return tag;
  }
}