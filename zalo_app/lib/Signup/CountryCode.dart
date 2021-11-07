import 'package:flutter/material.dart';
import 'package:zalo_app/model/CountryModel.dart';

class CountryCode extends StatefulWidget {
  // const CountryCode({Key key}) : super(key: key);

  @override
  _CountryCodeState createState() => _CountryCodeState();
}

class _CountryCodeState extends State<CountryCode> {
  List<CountryModel> countries = [
    CountryModel(name: 'Afghanistan', code: '+93'),
    CountryModel(name: 'Albania', code: '+355'),
    CountryModel(name: 'Algeria', code: '+213'),
    CountryModel(name: 'China', code: '+86'),
    CountryModel(name: 'Egypt', code: '+20'),
    CountryModel(name: 'India', code: '+91'),
    CountryModel(name: 'Singapore', code: '+65'),
    CountryModel(name: 'Thailand', code: '+66'),
    CountryModel(name: 'Vietnam', code: '+84'),
    CountryModel(name: 'United States', code: '+1'),
    CountryModel(name: 'United Kingdom', code: '+44'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chon ma khu vuc'),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
            
            color: Colors.white,
            size: 30,
            
          ),
          onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index].name),
            trailing: Text(countries[index].code),
            onTap: () {
              Navigator.pop(context, countries[index]);
            },
          );
        },
      ),
    );
  }

  Widget card(CountryModel country) {
      return Card(
        margin: EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(country.name),
              Text(country.code),
            ],
          ),
        ),
      );
    }
}