import "package:flutter/material.dart";
import 'package:padak_starter/model/widget/star_rating_bar.dart';

class CommentPage extends StatefulWidget {
  final String movieTitle;
  final String movieId;

  CommentPage(this.movieTitle, this.movieId);

  @override
  CommentPageState createState() => CommentPageState(movieTitle, movieId);
}

class CommentPageState extends State<CommentPage> {
  String movieTitle;
  String movieId;

  final scaffoldState = GlobalKey<ScaffoldState>();
  int _rating = 0;
  String _writer = "";
  String _content = "";

  CommentPageState(String movieTitle, String movieId) {
    this.movieTitle = movieTitle;
    this.movieId = movieId;
  }

  // 3-1. 댓글 입력 화면 (화면 구현)
  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text('한줄평 작성'),
          actions: <Widget>[_submitButton()],
        ),
        body: WillPopScope(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildMovieTitle(),
                    _buildUserRating(),
                    _buildHorizontalDivider(),
                    _buildNickNameInputForm(),
                    _buildCommentInputForm()
                  ],
                )),
          ),
          onWillPop: () {
            Navigator.of(context).pop(false);
            return Future.value(false);
          },
        ),
      );

  // 3-2. 댓글 입력 화면 (_buildSubmitButton)
  Widget _submitButton() => IconButton(
        icon: Icon(Icons.send, color: Colors.white, size: 25),
        onPressed: () {
          if (_writer.isEmpty || _content.isEmpty) {
            _showSnackBar('모든 정보를 입력해주세요.');
          } else {
            Navigator.of(context).pop(true);
          }
        },
      );

  Widget _buildMovieTitle() => Container(
      padding: EdgeInsets.all(10),
      child: Text(widget.movieTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));

  Widget _buildUserRating() => Column(
        children: <Widget>[
          StarRatingBar(
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          Text((_rating / 2.0).toString())
        ],
      );

  Widget _buildHorizontalDivider() => Container(
        margin: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        width: double.infinity,
        height: 10,
        color: Colors.grey.shade400,
      );

  Widget _buildNickNameInputForm() => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: (text) => _writer = text,
          maxLines: 1,
          maxLength: 20,
          decoration: InputDecoration(
              hintText: '닉네임을 입력해주세요.',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(),
              )),
        ),
      );

  Widget _buildCommentInputForm() => Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
        child: TextField(
          onChanged: (text) => _content = text,
          maxLines: null,
          maxLength: 100,
          decoration: InputDecoration(
              hintText: '한줄평을 작성해주세요',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(8))),
        ),
      );

  void _showSnackBar(String text) {
    scaffoldState.currentState.showSnackBar(SnackBar(content: Text(text)));
  }
}
