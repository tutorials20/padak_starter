import 'package:flutter/material.dart';
import 'package:padak_starter/detail_page.dart';

import 'model/data/dummys_repository.dart';
import 'model/response/movies_response.dart';

// 1-3. 리스트 화면 (임포트)
class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1-3. 리스트 화면 (동적 데이터 추가)
    final List movies = DummysRepository.loadDummyMovies();

    // 1-3. 리스트 화면 (초기 리스트 구현)
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) =>
          _buildGridItem(context, movie: movies[index]),
    );
  }

  _buildDummyItem() => Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://padakpadak.s3.ap-northeast-2.amazonaws.com/image/1.jpg',
              height: 120,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      '신과함께-죄와벌(bee)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    _buildGradeImage(12)
                  ]),
                  Row(children: [
                    SizedBox(height: 10),
                  ]),
                  Row(children: [
                    Text('평점 : 139'),
                    SizedBox(width: 10),
                    Text('예매순위 : 1'),
                    SizedBox(width: 10),
                    Text('예매율 : 35.5'),
                  ]),
                  Row(children: [
                    SizedBox(height: 10),
                  ]),
                  Row(children: [
                    Text('개봉일 : 2020-20-20'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );

  _buildGridItem(BuildContext context, {@required Movie movie}) => InkWell(
        child: _buildItem(movie),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailPage(movie.id),
          ));
        },
      );

// 1-3. 리스트 화면 (고정 더미 데이터)

// 1-3. 리스트 화면 (동적 데이터 호출1)
  _buildItem(Movie movie) => Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.thumb,
              height: 120,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    _buildGradeImage(movie.grade)
                  ]),
                  Row(children: [
                    SizedBox(height: 10),
                  ]),
                  Row(children: [
                    Text('평점 : ${movie.userRating / 2}'),
                    SizedBox(width: 10),
                    Text('예매순위 : ${movie.reservationGrade}'),
                    SizedBox(width: 10),
                    Text('예매율 : ${movie.reservationRate}'),
                  ]),
                  Row(children: [
                    SizedBox(height: 10),
                  ]),
                  Row(children: [
                    Text('개봉일 : ${movie.date}'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );

// 1-3. 리스트 화면 (관람 등급 이미지 버튼 함수 생성)
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
}
