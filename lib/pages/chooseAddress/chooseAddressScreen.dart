import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oro_task/bloc/addressBloc.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/pages/setLocation/setLocation.dart';
import 'package:oro_task/theme.dart';

class ChooseAddressScreen extends StatefulWidget {
  ChooseAddressScreen({Key key}) : super(key: key);

  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        backwardsCompatibility: false,
        iconTheme: ThemeData.light().iconTheme,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your address",
                    style: OroTheme.headTextStyle28,
                  ),
                  Text(
                    "Select from saved addresses or add a new one",
                    style: OroTheme.visitTileInfoHead,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: BlocProvider.of<AddressBloc>(context).addressStream,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) if (snapshot.data.length > 0)
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                            children: snapshot.data
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      BlocProvider.of<VisitBloc>(context)
                                          .initialise(e);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFE5E5E5),
                                          width: 1,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {});
                                              },
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: SvgPicture.asset(
                                                  "illustrations/marker.svg",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e["userDefined"]["type"],
                                                  style: OroTheme.headTestStyle,
                                                ),
                                                Text(
                                                  "${e["userDefined"]["pinPoint"] ?? ""}, ${e["address"]["streetAddress"] ?? ""}, ${e["address"]["city"] ?? ""},${e["address"]["region"] ?? ""}, ${e["address"]["countryName"] ?? ""}, ${e["address"]["countryCode"] ?? ""},",
                                                  style:
                                                      OroTheme.tileInfoHead400,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: InkWell(
                                                // onTap: onTap,
                                                child: ClipOval(
                                                  child: Container(
                                                    height: 25,
                                                    alignment: Alignment.center,
                                                    width: 25,
                                                    color: Color(0xFFEC4E4E),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wrong_location_outlined,
                            size: 100,
                          ),
                          Text(
                            "You don’t have any saved addresses. Add a new one to proceed.",
                            style: OroTheme.subHeadStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return BlocProvider<AddressBloc>(
                          bloc: BlocProvider.of<AddressBloc>(context),
                          child: SetAddressScreen(),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFEC4E4E),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Add a new address",
                        style: OroTheme.headTestStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "Choose a custom location",
                        style: OroTheme.visitTileInfoSubHead
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
