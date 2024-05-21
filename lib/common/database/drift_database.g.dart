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
  @override
  List<GeneratedColumn> get $columns =>
      [date, summary, content, emotion, createdAt, updatedAt];
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
  const DiaryInfo(
      {required this.date,
      required this.summary,
      required this.content,
      required this.emotion,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['summary'] = Variable<String>(summary);
    map['content'] = Variable<String>(content);
    map['emotion'] = Variable<int>(emotion);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
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
    };
  }

  DiaryInfo copyWith(
          {DateTime? date,
          String? summary,
          String? content,
          int? emotion,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DiaryInfo(
        date: date ?? this.date,
        summary: summary ?? this.summary,
        content: content ?? this.content,
        emotion: emotion ?? this.emotion,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('DiaryInfo(')
          ..write('date: $date, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('emotion: $emotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, summary, content, emotion, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryInfo &&
          other.date == this.date &&
          other.summary == this.summary &&
          other.content == this.content &&
          other.emotion == this.emotion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DiaryInfosCompanion extends UpdateCompanion<DiaryInfo> {
  final Value<DateTime> date;
  final Value<String> summary;
  final Value<String> content;
  final Value<int> emotion;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DiaryInfosCompanion({
    this.date = const Value.absent(),
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.emotion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryInfosCompanion.insert({
    required DateTime date,
    required String summary,
    required String content,
    required int emotion,
    required DateTime createdAt,
    required DateTime updatedAt,
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
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (summary != null) 'summary': summary,
      if (content != null) 'content': content,
      if (emotion != null) 'emotion': emotion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
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
      Value<int>? rowid}) {
    return DiaryInfosCompanion(
      date: date ?? this.date,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
