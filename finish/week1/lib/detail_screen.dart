import 'package:flutter/material.dart';
import 'package:week1/profile.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.data});

  final Profile data;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var isFavorite = false;

  Widget _companyIcon() {
    return Container(
      width: double.infinity,
      height: 64,
      margin: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(widget.data.icon),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.data.description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.data.background),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: _companyIcon(),
            )
          ],
        ),
      ),
    );
  }

  Widget _tvAbout() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _tvAboutContent() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
          right: 24,
          left: 24,
        ),
        margin: const EdgeInsets.only(
          bottom: 100,
        ),
        child: Text(
          widget.data.about,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _button() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () => setState(() => isFavorite = !isFavorite),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => isFavorite
                    ? const Color(0xFFFF5959)
                    : const Color(0xFF59C3FF),
              ),
              minimumSize: MaterialStateProperty.resolveWith(
                (states) => const Size(double.infinity, 52),
              ),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
          child: Text(isFavorite ? 'Delete from favorite' : 'Add to favorite'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _header(),
              _tvAbout(),
              _tvAboutContent(),
            ],
          ),
          _button(),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
