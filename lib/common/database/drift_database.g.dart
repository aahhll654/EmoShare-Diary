// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DiaryInfosTable extends DiaryInfos
    with TableInfo<$DiaryInfosTable, DiaryInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emotionMeta =
      const VerificationMeta('emotion');
  @override
  late final GeneratedColumn<int> emotion = GeneratedColumn<int>(
      'emotion', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [date, summary, content, emotion, createdAt, updatedAt, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary_infos';
  @override
  VerificationContext validateIntegrity(Insertable<DiaryInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('emotion')) {
      context.handle(_emotionMeta,
          emotion.isAcceptableOrUnknown(data['emotion']!, _emotionMeta));
    } else if (isInserting) {
      context.missing(_emotionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DiaryInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryInfo(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      emotion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}emotion'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
    );
  }

  @override
  $DiaryInfosTable createAlias(String alias) {
    return $DiaryInfosTable(attachedDatabase, alias);
  }
}

class DiaryInfo extends DataClass implements Insertable<DiaryInfo> {
  final DateTime date;
  final String summary;
  final String content;
  final int emotion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Uint8List? image;
  const DiaryInfo(
      {required this.date,
      required this.summary,
      required this.content,
      required this.emotion,
      required this.createdAt,
      required this.updatedAt,
      this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['summary'] = Variable<String>(summary);
    map['content'] = Variable<String>(content);
    map['emotion'] = Variable<int>(emotion);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    return map;
  }

  DiaryInfosCompanion toCompanion(bool nullToAbsent) {
    return DiaryInfosCompanion(
      date: Value(date),
      summary: Value(summary),
      content: Value(content),
      emotion: Value(emotion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory DiaryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryInfo(
      date: serializer.fromJson<DateTime>(json['date']),
      summary: serializer.fromJson<String>(json['summary']),
      content: serializer.fromJson<String>(json['content']),
      emotion: serializer.fromJson<int>(json['emotion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      image: serializer.fromJson<Uint8List?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'summary': serializer.toJson<String>(summary),
      'content': serializer.toJson<String>(content),
      'emotion': serializer.toJson<int>(emotion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'image': serializer.toJson<Uint8List?>(image),
    };
  }

  DiaryInfo copyWith(
          {DateTime? date,
          String? summary,
          String? content,
          int? emotion,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<Uint8List?> image = const Value.absent()}) =>
      DiaryInfo(
        date: date ?? this.date,
        summary: summary ?? this.summary,
        content: content ?? this.content,
        emotion: emotion ?? this.emotion,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        image: image.present ? image.value : this.image,
      );
  DiaryInfo copyWithCompanion(DiaryInfosCompanion data) {
    return DiaryInfo(
      date: data.date.present ? data.date.value : this.date,
      summary: data.summary.present ? data.summary.value : this.summary,
      content: data.content.present ? data.content.value : this.content,
      emotion: data.emotion.present ? data.emotion.value : this.emotion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiaryInfo(')
          ..write('date: $date, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('emotion: $emotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, summary, content, emotion, createdAt,
      updatedAt, $driftBlobEquality.hash(image));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryInfo &&
          other.date == this.date &&
          other.summary == this.summary &&
          other.content == this.content &&
          other.emotion == this.emotion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          $driftBlobEquality.equals(other.image, this.image));
}

class DiaryInfosCompanion extends UpdateCompanion<DiaryInfo> {
  final Value<DateTime> date;
  final Value<String> summary;
  final Value<String> content;
  final Value<int> emotion;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<Uint8List?> image;
  final Value<int> rowid;
  const DiaryInfosCompanion({
    this.date = const Value.absent(),
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.emotion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryInfosCompanion.insert({
    required DateTime date,
    required String summary,
    required String content,
    required int emotion,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        summary = Value(summary),
        content = Value(content),
        emotion = Value(emotion),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DiaryInfo> custom({
    Expression<DateTime>? date,
    Expression<String>? summary,
    Expression<String>? content,
    Expression<int>? emotion,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<Uint8List>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (summary != null) 'summary': summary,
      if (content != null) 'content': content,
      if (emotion != null) 'emotion': emotion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiaryInfosCompanion copyWith(
      {Value<DateTime>? date,
      Value<String>? summary,
      Value<String>? content,
      Value<int>? emotion,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<Uint8List?>? image,
      Value<int>? rowid}) {
    return DiaryInfosCompanion(
      date: date ?? this.date,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (emotion.present) {
      map['emotion'] = Variable<int>(emotion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryInfosCompanion(')
          ..write('date: $date, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('emotion: $emotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyDiaryInfosTable extends WeeklyDiaryInfos
    with TableInfo<$WeeklyDiaryInfosTable, WeeklyDiaryInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyDiaryInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weeknumberMeta =
      const VerificationMeta('weeknumber');
  @override
  late final GeneratedColumn<int> weeknumber = GeneratedColumn<int>(
      'weeknumber', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [year, weeknumber, summary, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_diary_infos';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklyDiaryInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('weeknumber')) {
      context.handle(
          _weeknumberMeta,
          weeknumber.isAcceptableOrUnknown(
              data['weeknumber']!, _weeknumberMeta));
    } else if (isInserting) {
      context.missing(_weeknumberMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year, weeknumber};
  @override
  WeeklyDiaryInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyDiaryInfo(
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      weeknumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weeknumber'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WeeklyDiaryInfosTable createAlias(String alias) {
    return $WeeklyDiaryInfosTable(attachedDatabase, alias);
  }
}

class WeeklyDiaryInfo extends DataClass implements Insertable<WeeklyDiaryInfo> {
  final int year;
  final int weeknumber;
  final String summary;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WeeklyDiaryInfo(
      {required this.year,
      required this.weeknumber,
      required this.summary,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['weeknumber'] = Variable<int>(weeknumber);
    map['summary'] = Variable<String>(summary);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WeeklyDiaryInfosCompanion toCompanion(bool nullToAbsent) {
    return WeeklyDiaryInfosCompanion(
      year: Value(year),
      weeknumber: Value(weeknumber),
      summary: Value(summary),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WeeklyDiaryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyDiaryInfo(
      year: serializer.fromJson<int>(json['year']),
      weeknumber: serializer.fromJson<int>(json['weeknumber']),
      summary: serializer.fromJson<String>(json['summary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'weeknumber': serializer.toJson<int>(weeknumber),
      'summary': serializer.toJson<String>(summary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WeeklyDiaryInfo copyWith(
          {int? year,
          int? weeknumber,
          String? summary,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WeeklyDiaryInfo(
        year: year ?? this.year,
        weeknumber: weeknumber ?? this.weeknumber,
        summary: summary ?? this.summary,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WeeklyDiaryInfo copyWithCompanion(WeeklyDiaryInfosCompanion data) {
    return WeeklyDiaryInfo(
      year: data.year.present ? data.year.value : this.year,
      weeknumber:
          data.weeknumber.present ? data.weeknumber.value : this.weeknumber,
      summary: data.summary.present ? data.summary.value : this.summary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyDiaryInfo(')
          ..write('year: $year, ')
          ..write('weeknumber: $weeknumber, ')
          ..write('summary: $summary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(year, weeknumber, summary, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyDiaryInfo &&
          other.year == this.year &&
          other.weeknumber == this.weeknumber &&
          other.summary == this.summary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WeeklyDiaryInfosCompanion extends UpdateCompanion<WeeklyDiaryInfo> {
  final Value<int> year;
  final Value<int> weeknumber;
  final Value<String> summary;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WeeklyDiaryInfosCompanion({
    this.year = const Value.absent(),
    this.weeknumber = const Value.absent(),
    this.summary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyDiaryInfosCompanion.insert({
    required int year,
    required int weeknumber,
    required String summary,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : year = Value(year),
        weeknumber = Value(weeknumber),
        summary = Value(summary),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<WeeklyDiaryInfo> custom({
    Expression<int>? year,
    Expression<int>? weeknumber,
    Expression<String>? summary,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (weeknumber != null) 'weeknumber': weeknumber,
      if (summary != null) 'summary': summary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyDiaryInfosCompanion copyWith(
      {Value<int>? year,
      Value<int>? weeknumber,
      Value<String>? summary,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return WeeklyDiaryInfosCompanion(
      year: year ?? this.year,
      weeknumber: weeknumber ?? this.weeknumber,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (weeknumber.present) {
      map['weeknumber'] = Variable<int>(weeknumber.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyDiaryInfosCompanion(')
          ..write('year: $year, ')
          ..write('weeknumber: $weeknumber, ')
          ..write('summary: $summary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyDiaryInfosTable extends MonthlyDiaryInfos
    with TableInfo<$MonthlyDiaryInfosTable, MonthlyDiaryInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyDiaryInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [year, month, summary, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_diary_infos';
  @override
  VerificationContext validateIntegrity(Insertable<MonthlyDiaryInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year, month};
  @override
  MonthlyDiaryInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyDiaryInfo(
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MonthlyDiaryInfosTable createAlias(String alias) {
    return $MonthlyDiaryInfosTable(attachedDatabase, alias);
  }
}

class MonthlyDiaryInfo extends DataClass
    implements Insertable<MonthlyDiaryInfo> {
  final int year;
  final int month;
  final String summary;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MonthlyDiaryInfo(
      {required this.year,
      required this.month,
      required this.summary,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['summary'] = Variable<String>(summary);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MonthlyDiaryInfosCompanion toCompanion(bool nullToAbsent) {
    return MonthlyDiaryInfosCompanion(
      year: Value(year),
      month: Value(month),
      summary: Value(summary),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MonthlyDiaryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyDiaryInfo(
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      summary: serializer.fromJson<String>(json['summary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'summary': serializer.toJson<String>(summary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MonthlyDiaryInfo copyWith(
          {int? year,
          int? month,
          String? summary,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      MonthlyDiaryInfo(
        year: year ?? this.year,
        month: month ?? this.month,
        summary: summary ?? this.summary,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MonthlyDiaryInfo copyWithCompanion(MonthlyDiaryInfosCompanion data) {
    return MonthlyDiaryInfo(
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      summary: data.summary.present ? data.summary.value : this.summary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyDiaryInfo(')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('summary: $summary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(year, month, summary, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyDiaryInfo &&
          other.year == this.year &&
          other.month == this.month &&
          other.summary == this.summary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MonthlyDiaryInfosCompanion extends UpdateCompanion<MonthlyDiaryInfo> {
  final Value<int> year;
  final Value<int> month;
  final Value<String> summary;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MonthlyDiaryInfosCompanion({
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.summary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyDiaryInfosCompanion.insert({
    required int year,
    required int month,
    required String summary,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : year = Value(year),
        month = Value(month),
        summary = Value(summary),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MonthlyDiaryInfo> custom({
    Expression<int>? year,
    Expression<int>? month,
    Expression<String>? summary,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (summary != null) 'summary': summary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyDiaryInfosCompanion copyWith(
      {Value<int>? year,
      Value<int>? month,
      Value<String>? summary,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return MonthlyDiaryInfosCompanion(
      year: year ?? this.year,
      month: month ?? this.month,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyDiaryInfosCompanion(')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('summary: $summary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $DiaryInfosTable diaryInfos = $DiaryInfosTable(this);
  late final $WeeklyDiaryInfosTable weeklyDiaryInfos =
      $WeeklyDiaryInfosTable(this);
  late final $MonthlyDiaryInfosTable monthlyDiaryInfos =
      $MonthlyDiaryInfosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [diaryInfos, weeklyDiaryInfos, monthlyDiaryInfos];
}

typedef $$DiaryInfosTableCreateCompanionBuilder = DiaryInfosCompanion Function({
  required DateTime date,
  required String summary,
  required String content,
  required int emotion,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<Uint8List?> image,
  Value<int> rowid,
});
typedef $$DiaryInfosTableUpdateCompanionBuilder = DiaryInfosCompanion Function({
  Value<DateTime> date,
  Value<String> summary,
  Value<String> content,
  Value<int> emotion,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<Uint8List?> image,
  Value<int> rowid,
});

class $$DiaryInfosTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $DiaryInfosTable> {
  $$DiaryInfosTableFilterComposer(super.$state);
  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get emotion => $state.composableBuilder(
      column: $state.table.emotion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DiaryInfosTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $DiaryInfosTable> {
  $$DiaryInfosTableOrderingComposer(super.$state);
  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get emotion => $state.composableBuilder(
      column: $state.table.emotion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$DiaryInfosTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $DiaryInfosTable,
    DiaryInfo,
    $$DiaryInfosTableFilterComposer,
    $$DiaryInfosTableOrderingComposer,
    $$DiaryInfosTableCreateCompanionBuilder,
    $$DiaryInfosTableUpdateCompanionBuilder,
    (DiaryInfo, BaseReferences<_$LocalDatabase, $DiaryInfosTable, DiaryInfo>),
    DiaryInfo,
    PrefetchHooks Function()> {
  $$DiaryInfosTableTableManager(_$LocalDatabase db, $DiaryInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DiaryInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DiaryInfosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> emotion = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<Uint8List?> image = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DiaryInfosCompanion(
            date: date,
            summary: summary,
            content: content,
            emotion: emotion,
            createdAt: createdAt,
            updatedAt: updatedAt,
            image: image,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            required String summary,
            required String content,
            required int emotion,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<Uint8List?> image = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DiaryInfosCompanion.insert(
            date: date,
            summary: summary,
            content: content,
            emotion: emotion,
            createdAt: createdAt,
            updatedAt: updatedAt,
            image: image,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DiaryInfosTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $DiaryInfosTable,
    DiaryInfo,
    $$DiaryInfosTableFilterComposer,
    $$DiaryInfosTableOrderingComposer,
    $$DiaryInfosTableCreateCompanionBuilder,
    $$DiaryInfosTableUpdateCompanionBuilder,
    (DiaryInfo, BaseReferences<_$LocalDatabase, $DiaryInfosTable, DiaryInfo>),
    DiaryInfo,
    PrefetchHooks Function()>;
typedef $$WeeklyDiaryInfosTableCreateCompanionBuilder
    = WeeklyDiaryInfosCompanion Function({
  required int year,
  required int weeknumber,
  required String summary,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$WeeklyDiaryInfosTableUpdateCompanionBuilder
    = WeeklyDiaryInfosCompanion Function({
  Value<int> year,
  Value<int> weeknumber,
  Value<String> summary,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$WeeklyDiaryInfosTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $WeeklyDiaryInfosTable> {
  $$WeeklyDiaryInfosTableFilterComposer(super.$state);
  ColumnFilters<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get weeknumber => $state.composableBuilder(
      column: $state.table.weeknumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WeeklyDiaryInfosTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $WeeklyDiaryInfosTable> {
  $$WeeklyDiaryInfosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get weeknumber => $state.composableBuilder(
      column: $state.table.weeknumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$WeeklyDiaryInfosTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $WeeklyDiaryInfosTable,
    WeeklyDiaryInfo,
    $$WeeklyDiaryInfosTableFilterComposer,
    $$WeeklyDiaryInfosTableOrderingComposer,
    $$WeeklyDiaryInfosTableCreateCompanionBuilder,
    $$WeeklyDiaryInfosTableUpdateCompanionBuilder,
    (
      WeeklyDiaryInfo,
      BaseReferences<_$LocalDatabase, $WeeklyDiaryInfosTable, WeeklyDiaryInfo>
    ),
    WeeklyDiaryInfo,
    PrefetchHooks Function()> {
  $$WeeklyDiaryInfosTableTableManager(
      _$LocalDatabase db, $WeeklyDiaryInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WeeklyDiaryInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WeeklyDiaryInfosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> year = const Value.absent(),
            Value<int> weeknumber = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyDiaryInfosCompanion(
            year: year,
            weeknumber: weeknumber,
            summary: summary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int year,
            required int weeknumber,
            required String summary,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyDiaryInfosCompanion.insert(
            year: year,
            weeknumber: weeknumber,
            summary: summary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeeklyDiaryInfosTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $WeeklyDiaryInfosTable,
    WeeklyDiaryInfo,
    $$WeeklyDiaryInfosTableFilterComposer,
    $$WeeklyDiaryInfosTableOrderingComposer,
    $$WeeklyDiaryInfosTableCreateCompanionBuilder,
    $$WeeklyDiaryInfosTableUpdateCompanionBuilder,
    (
      WeeklyDiaryInfo,
      BaseReferences<_$LocalDatabase, $WeeklyDiaryInfosTable, WeeklyDiaryInfo>
    ),
    WeeklyDiaryInfo,
    PrefetchHooks Function()>;
typedef $$MonthlyDiaryInfosTableCreateCompanionBuilder
    = MonthlyDiaryInfosCompanion Function({
  required int year,
  required int month,
  required String summary,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MonthlyDiaryInfosTableUpdateCompanionBuilder
    = MonthlyDiaryInfosCompanion Function({
  Value<int> year,
  Value<int> month,
  Value<String> summary,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$MonthlyDiaryInfosTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $MonthlyDiaryInfosTable> {
  $$MonthlyDiaryInfosTableFilterComposer(super.$state);
  ColumnFilters<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MonthlyDiaryInfosTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $MonthlyDiaryInfosTable> {
  $$MonthlyDiaryInfosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$MonthlyDiaryInfosTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $MonthlyDiaryInfosTable,
    MonthlyDiaryInfo,
    $$MonthlyDiaryInfosTableFilterComposer,
    $$MonthlyDiaryInfosTableOrderingComposer,
    $$MonthlyDiaryInfosTableCreateCompanionBuilder,
    $$MonthlyDiaryInfosTableUpdateCompanionBuilder,
    (
      MonthlyDiaryInfo,
      BaseReferences<_$LocalDatabase, $MonthlyDiaryInfosTable, MonthlyDiaryInfo>
    ),
    MonthlyDiaryInfo,
    PrefetchHooks Function()> {
  $$MonthlyDiaryInfosTableTableManager(
      _$LocalDatabase db, $MonthlyDiaryInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MonthlyDiaryInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$MonthlyDiaryInfosTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> year = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyDiaryInfosCompanion(
            year: year,
            month: month,
            summary: summary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int year,
            required int month,
            required String summary,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyDiaryInfosCompanion.insert(
            year: year,
            month: month,
            summary: summary,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonthlyDiaryInfosTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $MonthlyDiaryInfosTable,
    MonthlyDiaryInfo,
    $$MonthlyDiaryInfosTableFilterComposer,
    $$MonthlyDiaryInfosTableOrderingComposer,
    $$MonthlyDiaryInfosTableCreateCompanionBuilder,
    $$MonthlyDiaryInfosTableUpdateCompanionBuilder,
    (
      MonthlyDiaryInfo,
      BaseReferences<_$LocalDatabase, $MonthlyDiaryInfosTable, MonthlyDiaryInfo>
    ),
    MonthlyDiaryInfo,
    PrefetchHooks Function()>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$DiaryInfosTableTableManager get diaryInfos =>
      $$DiaryInfosTableTableManager(_db, _db.diaryInfos);
  $$WeeklyDiaryInfosTableTableManager get weeklyDiaryInfos =>
      $$WeeklyDiaryInfosTableTableManager(_db, _db.weeklyDiaryInfos);
  $$MonthlyDiaryInfosTableTableManager get monthlyDiaryInfos =>
      $$MonthlyDiaryInfosTableTableManager(_db, _db.monthlyDiaryInfos);
}
