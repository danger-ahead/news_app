// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsTopicAdapter extends TypeAdapter<NewsTopic> {
  @override
  final int typeId = 1;

  @override
  NewsTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsTopic(
      totalResults: fields[0] as int,
      articles: (fields[1] as List).cast<Article>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsTopic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.totalResults)
      ..writeByte(1)
      ..write(obj.articles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 2;

  @override
  Article read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Article(
      source: fields[0] as Source,
      author: fields[1] as String?,
      title: fields[2] as String,
      description: fields[3] as String,
      url: fields[4] as String,
      urlToImage: fields[5] as String?,
      publishedAt: fields[6] as DateTime,
      content: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.source)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.urlToImage)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SourceAdapter extends TypeAdapter<Source> {
  @override
  final int typeId = 3;

  @override
  Source read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Source(
      id: fields[0] as String?,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Source obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
