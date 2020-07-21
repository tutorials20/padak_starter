import "package:flutter/material.dart";

import 'model/data/dummys_repository.dart';
import 'model/response/comments_response.dart';
import 'model/response/movie_response.dart';

class DetailPage extends StatefulWidget {
  final String movieId;

  DetailPage(this.movieId);

  @override
  State<StatefulWidget> createState() {
    return _DetailState(movieId);
  }
}

class _DetailState extends State<DetailPage> {
  String movieId;
  String _movieTitle = '';
  MovieResponse _details;
  CommentsResponse _commentsResponse;

  _DetailState(String movieId){
    this.movieId = movieId;
    _details = DummysRepository.loadDummyMovie(movieId);
  }

  @override
  Widget build(BuildContext context) {
    // 2-1. 상세 화면 (테스트 데이터 설정 - 영화 상세)

    // 2-5. 상세 화면 (테스트 데이터 설정 - 댓글 상세)

    return Scaffold(
        appBar: AppBar(
          // 2-1. 상세 화면 (제목 설정)
          title: Text(_details.title),
        ),
        // 2-1. 상세 화면 (전체 화면 세팅1)
        body: _buildContent()
    );
  }

  // 2-1. 상세 화면 (전체 화면 세팅2)

  _buildMovieSummary()=> Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          Image.network(_details.image, height: 180,),
          SizedBox(width: 10,),
          _buildMovieSummaryTextColumn(),
        ],
      ),
      SizedBox(height: 10,),
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

  // 2-2. Summary 화면 (1-2 과정)

  // 2-2. Summary 화면 (2-2 과정 - 예매율)

  // 2-2. Summary 화면 (2-2 과정 - 평점)

  // 2-2. Summary 화면 (2-2 과정 - 누적관객수)

  // 2-2. Summary 화면 (2-2 과정 - 구분선)

  Widget _buildMovieSynopsis() {
    // 2-3. Synopsis 화면 (화면 구현)
    return Text("영화 줄거리");
  }
  Widget _buildMovieCast() {
    // 2-4. MovieCast 화면 (감독 / 출연 구현)
    return Text("감독/출연");
  }
  Widget _buildComment() {
    // 2-5. Comment 화면 (화면 구현)
    return Text("댓글 화면");
  }

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

  _buildMovieSummaryTextColumn() =>Text('_buildMovieSummaryTextColumn');

  _buildReservationRate()  => Text('예매율');

  _buildUserRating()  => Text('평점');

  _buildVerticalDivider() => Text('|');

  _buildAudience() => Text('관객수');

  // 2-5. Comment 화면 (한줄평 리스트)

  // 2-5. Comment 화면 (한줄평 아이템 화면 구축)

  // 2-5. Comment 화면 (포맷에 맞춰 날짜 데이터 반환)

  // 2-5. Comment 화면 (댓글 입력 창으로 이동)
}