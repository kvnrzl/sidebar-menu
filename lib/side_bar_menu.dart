import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebar_menu/helpers/card_helper.dart';
import 'package:sidebar_menu/models/card_model.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu>
    with SingleTickerProviderStateMixin {
  List<CardModel> listOfCard;
  bool isCollapsed = true;
  double screenHeight, screenWidth;
  final Duration duration = const Duration(milliseconds: 300);
  PageController _pageController = PageController(viewportFraction: 0.8);
  // double currentPageValue;
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _sideMenuScaleAnimation;
  Animation<Offset> _sideMenuSlideAnimation;

  @override
  void initState() {
    super.initState();
    CardHelper cardObj = CardHelper();
    listOfCard = cardObj.getCard();
    // _pageController.addListener(() {
    //   currentPageValue = _pageController.page;
    // });
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _sideMenuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _sideMenuSlideAnimation =
        Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            sideMenuWidget(context),
            homePageWidget(context),
          ],
        ),
      ),
    );
  }

  Widget sideMenuWidget(context) {
    return SlideTransition(
      position: _sideMenuSlideAnimation,
      child: ScaleTransition(
        scale: _sideMenuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.water_damage_sharp, color: Colors.grey),
                  label: Text('Dashboard',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.message_sharp, color: Colors.grey),
                  label: Text('Messages',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.payment_sharp, color: Colors.grey),
                  label: Text('Utility Bills',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.send_to_mobile, color: Colors.grey),
                  label: Text('Funds Transfer',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.dashboard_sharp, color: Colors.grey),
                  label: Text('Branches',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homePageWidget(context) {
    return AnimatedPositioned(
      duration: duration,
      // top: isCollapsed ? 0 : 0.1 * screenHeight,
      // bottom: isCollapsed ? 0 : 0.1 * screenHeight,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 8,
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'My Cards',
                        style: GoogleFonts.poppins(
                            fontSize: 22, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    margin: EdgeInsetsDirectional.only(top: 48),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: listOfCard.length,
                      itemBuilder: (context, index) {
                        // double difference = index - currentPageValue;
                        // if (difference < 0) difference *= -1;
                        // difference = min(1, difference);
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(3, 10),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  listOfCard[index].balance,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20),
                      ),
                      Icon(
                        Icons.settings_backup_restore,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'Buy Merchant',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Tokopedia',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                            'Rp121.000',
                            style: GoogleFonts.poppins(color: Colors.red[600]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 16,
                        );
                      },
                      itemCount: 15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
