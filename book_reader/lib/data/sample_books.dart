import '../models/book.dart';

const List<Book> sampleBooks = [
  Book(
    id: 'book_1',
    title: 'Flutter Căn Bản',
    author: 'Mini Reader Team',
    description: 'Một cuốn sách ngắn giúp bạn ôn lại Flutter cơ bản.',
    chapters: [
      Chapter(
        id: 'chapter_1',
        title: 'Chương 1: Flutter là gì?',
        content: '''
Flutter là một UI toolkit dùng để xây dựng ứng dụng đa nền tảng.

Trong Flutter, mọi thứ trên giao diện đều là widget.
Một màn hình có thể được ghép từ nhiều widget nhỏ như Text, Column, Row, ListView, Card và Button.

Ý tưởng quan trọng nhất khi học Flutter là:
hãy chia giao diện lớn thành nhiều phần nhỏ.
''',
      ),
      Chapter(
        id: 'chapter_2',
        title: 'Chương 2: Widget cơ bản',
        content: '''
Widget là khối xây dựng giao diện trong Flutter.

Ví dụ:
- Text dùng để hiển thị chữ.
- ListView dùng để hiển thị danh sách.
- Scaffold tạo khung màn hình.
- AppBar tạo thanh tiêu đề.

Khi hiểu widget, bạn sẽ dễ dàng xây dựng màn hình hơn.
''',
      ),
    ],
  ),
  Book(
    id: 'book_2',
    title: 'Dart Nhập Môn',
    author: 'Mini Reader Team',
    description: 'Ôn tập nhanh về biến, hàm, class và list trong Dart.',
    chapters: [
      Chapter(
        id: 'chapter_1',
        title: 'Chương 1: Biến và kiểu dữ liệu',
        content: '''
Dart là ngôn ngữ lập trình dùng trong Flutter.

Một số kiểu dữ liệu thường gặp:
- String: chuỗi ký tự.
- int: số nguyên.
- double: số thực.
- bool: đúng hoặc sai.
- List: danh sách dữ liệu.
''',
      ),
      Chapter(
        id: 'chapter_2',
        title: 'Chương 2: Class và Object',
        content: '''
Class là bản thiết kế.
Object là đối tượng được tạo ra từ bản thiết kế đó.

Ví dụ:
Book là class.
Một cuốn "Flutter Căn Bản" cụ thể là object.
''',
      ),
    ],
  ),
];