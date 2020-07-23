import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import 'comment_page.dart';
import 'model/data/dummys_repository.dart';
import 'model/response/comments_response.dart';
import 'model/response/movie_response.dart';

class DetailPage extends StatefulWidget {
  final String movieId;

  DetailPage(this.movieId);

  @override
  State<StatefulWidget> createState() => _DetailState(movieId);
}

class _DetailState extends State<DetailPage> {
  MovieResponse _details;
  CommentsResponse _comment;

  _DetailState(String movieId) {
    this._details = DummysRepository.loadDummyMovie(movieId);
    this._comment = DummysRepository.loadComments(movieId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        // 2-1. 상세 화면 (제목 설정)
        title: Text(_details.title),
      ),
      // 2-1. 상세 화면 (전체 화면 세팅1)
      body: _buildContent());

  _buildContent() => SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            _buildMovieSummary(),
            _buildMovieSynopsis(),
            _buildMovieCast(),
            _buildComment(),
          ],
        ),
      );

  _buildMovieSummary() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                _details.image,
                height: 180,
              ),
              SizedBox(
                width: 10,
              ),
              _buildMovieSummaryTextColumn(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildReservationRate(),
              _buildVerticalDivider(),
              _buildUserRating(),
              _buildVerticalDivider(),
              _buildAudience(),
            ],
          ),
        ],
      );

  _buildMovieSummaryTextColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _details.title,
            style: TextStyle(fontSize: 22),
          ),
          Text(
            '${_details.date} 개봉',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '${_details.genre} / ${_details.duration}분',
            style: TextStyle(fontSize: 16),
          )
        ],
      );

  // 2-2. Summary 화면 (2-2 과정 - 예매율)
  _buildReservationRate() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('예매율',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('${_details.reservationGrade}위 ${_details.reservationRate}%')
        ],
      );

  // 2-2. Summary 화면 (2-2 과정 - 평점)
  _buildUserRating() => Column(
        children: <Widget>[
          Text('평점',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('${_details.userRating / 2}')
        ],
      );

  // 2-2. Summary 화면 (2-2 과정 - 구분선)
  _buildVerticalDivider() =>
      Container(width: 1, height: 50, color: Colors.grey);

  // 2-2. Summary 화면 (2-2 과정 - 누적관객수)
  _buildAudience() => Column(
        children: <Widget>[
          Text('누적관객수',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('${NumberFormat.decimalPattern().format(_details.audience)}')
        ],
      );

  // 2-3. Synopsis 화면 (화면 구현)
  _buildMovieSynopsis() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 10,
            color: Colors.grey.shade400,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '줄거리',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 16, top: 10, bottom: 5),
              child: Text(_details.synopsis))
        ],
      );

  _buildMovieCast() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 10,
            color: Colors.grey.shade400,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '감독/출연',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 16, top: 10, bottom: 5),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text('감독', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text(_details.director)
                ]),
                SizedBox(height: 5),
                Row(children: <Widget>[
                  Text('출연', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Expanded(child: Text(_details.actor))
                ])
              ]))
        ],
      );

  _buildComment() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 10,
            color: Colors.grey.shade400,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('한줄평',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.create),
                  color: Colors.blue,
                  onPressed: () => _openNewCommentPage(context),
                )
              ],
            ),
          ),
          _buildComments()
        ],
      );

  _buildComments() => ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.all(10),
      itemCount: _comment.comments.length,
      itemBuilder: (_, index) => _buildItem(comment: _comment.comments[index]));

  _buildItem({@required Comment comment}) => Container(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.person_pin, size: 50),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(comment.writer),
                SizedBox(width: 5),
                Text(_formatDateTime(comment.timestamp)),
                SizedBox(height: 5),
                Text(comment.contents)
              ],
            ),
          ],
        ),
      );

  _formatDateTime(int timestamp) => DateFormat('yyyy-MM-dd HH:mm:ss')
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));

  _openNewCommentPage(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommentPage(_details.title, _details.id)));
}
