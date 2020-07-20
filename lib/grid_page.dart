import 'package:flutter/material.dart';
import 'package:padak_starter/model/data/dummys_repository.dart';

import 'model/response/movies_response.dart';

// 1-3. Grid 리스트 화면 (임포트)

class GridPage extends StatelessWidget {
  // 1-4. Grid 리스트 화면 (동적 데이터 추가)
  final movies = DummysRepository.loadDummyMovies();

  @override
  Widget build(BuildContext context) {
    // 1-4. Grid 리스트 화면 (GridView 구축)
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) =>
          _buildGridItem(context, movie: movies[index]),
    );
  }

// 1-4. Grid 리스트 화면 (Grid 아이템 화면 구축)

// 1-4. Grid 리스트 화면 (관람 등급 이미지 버튼 함수 생성)
  _buildGradeImage(int grade) {
    switch (grade) {
      case 0:
        return Image.asset('assets/ic_allages.png');
      case 12:
        return Image.asset('assets/ic_12.png');
      case 15:
        return Image.asset('assets/ic_15.png');
      case 19:
        return Image.asset('assets/ic_19.png');
      default:
        return null;
    }
  }

  _buildGridItem(BuildContext context, {@required Movie movie}) => Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    movie.thumb,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: _buildGradeImage(movie.grade),
                  ),
                ],
              ),
            ),
            defaultMargin(),
            FittedBox(
              child: Text(
                movie.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            defaultMargin(),
            Text(
                '${movie.reservationGrade} 위(${movie.userRating}) / ${movie.reservationRate}%'),
            defaultMargin(),
            Text(movie.date),
          ],
        ),
      );

  defaultMargin() => SizedBox(
        height: 8,
      );
}
