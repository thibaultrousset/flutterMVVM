import 'package:exemple_mvvm/model/apis/api_response.dart';
import 'package:exemple_mvvm/model/media.dart';
import 'package:exemple_mvvm/view/widgets/player_list_widget.dart';
import 'package:exemple_mvvm/view/widgets/player_widget.dart';
import 'package:exemple_mvvm/view_model/media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<Media>? mediaList = apiResponse.data as List<Media>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: PlayerListWidget(mediaList!, (Media media) {
                Provider.of<MediaViewModel>(context, listen: false)
                    .setSelectedMedia(media);
              }),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlayerWidget(
                    mediaList: mediaList,
                    function: () {
                      setState(() {});
                    },
                    function2: (Media media) {
                      Provider.of<MediaViewModel>(context, listen: false)
                          .setSelectedMedia(media);
                    }),
              ),
            ),
          ],
        );
      case Status.ERROR:
        return Center(
          child: Text(apiResponse.message!),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the song by Artist'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<MediaViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Player'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.secondary.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        controller: _inputController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Provider.of<MediaViewModel>(context, listen: false)
                                .setSelectedMedia(null);

                            Provider.of<MediaViewModel>(context, listen: false)
                                .fetchMediaData(value);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter Artist Name',
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getMediaWidget(context, apiResponse)),
        ],
      ),
    );
  }
}
