import 'package:flutter/material.dart';

class DetailPerso extends StatefulWidget {
  final String name;
  final String image;

  DetailPerso({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  _DetailPersoState createState() => _DetailPersoState();
}

class _DetailPersoState extends State<DetailPerso> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color(0xFF15232E),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF15232E),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'Histoire'),
                Tab(text: 'Infos'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "He beat the former president known as \"The Beast\" by Spider. He wasn't the kind of man you would want as your savior of your country. He became the president to control the people...",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailInfoRow(title: 'Nom de super-héros', detail: 'Gary Callahan'),
                      DetailInfoRow(title: 'Nom réel', detail: 'Gary Callahan'),
                      DetailInfoRow(title: 'Alias', detail: 'The Smiler'),
                      DetailInfoRow(title: 'Éditeur', detail: 'Éditeur du personnage'),
                      DetailInfoRow(title: 'Créateurs', detail: 'Darick Robertson, Warren Ellis'),
                      DetailInfoRow(title: 'Genre', detail: 'Masculin'),
                      DetailInfoRow(title: 'Date de naissance', detail: 'Inconnue'),
                      DetailInfoRow(title: 'Décès', detail: 'N/A'),
                      // ... Plus de détails
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailInfoRow extends StatelessWidget {
  final String title;
  final String detail;

  const DetailInfoRow({Key? key, required this.title, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(detail, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailPerso(name: 'Nom Personnage', image: 'chemin_vers_image'),
    debugShowCheckedModeBanner: false,
  ));
}
