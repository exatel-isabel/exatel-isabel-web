import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:isabel/api/firebase_auth.dart';
import 'package:isabel/pages/schedule.dart';
import 'package:isabel/routes.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  String title = "Agenda";

  Widget pagesChild() {
    switch (title) {
      case "Agenda":
        return const SchedulePage();
      default:
        return Container(color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SliderDrawer(
          appBar: SliderAppBar(
            appBarHeight: 50,
            drawerIconColor: Colors.white,
            appBarColor: Colors.blue,
            appBarPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: IconButton(
              onPressed: () {}, // adiconar pesquisa de tarefas
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: _SliderView(
            onItemClick: (title) async {
              switch (title) {
                case "Sair":
                  {
                    await FireAuth().logout().then((value) =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.signinPage, (route) => false));
                    debugPrint("Saiu");
                  }
                default:
                  null;
              }
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                this.title = title;
              });
            },
          ),
          child: pagesChild(),
        ),
      ),
    );
  }
}

class _SliderView extends StatefulWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<_SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<_SliderView> {
  String name() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.displayName!;
    }
    return "Name User";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            name(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          ...[
            Menu(Icons.calendar_month, 'Agenda'),
            Menu(Icons.person_outline, 'Perfil'),
            Menu(Icons.logout_rounded, 'Sair')
          ]
              .map((menu) => _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  onTap: widget.onItemClick))
              .toList(),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'BalsamiqSans_Regular',
          ),
        ),
        leading: Icon(
          iconData,
          color: Colors.black,
        ),
        onTap: () => onTap?.call(title));
  }
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}
