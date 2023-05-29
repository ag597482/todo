class Task {
  int? _id;
  late String _title;
  String? _description;
  late String _date;
  late int _priority;
  late int _status;

  Task(this._title, this._date, this._priority, _status, [this._description]);

  Task.withId(this._id, this._title, this._date, this._priority, _status,
      [this._description]);

  int? get id => _id;

  String get title => _title;

  String get description => _description ?? '';

  int get priority => _priority;
  
  int get status => _status;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    }
  }

  set status(int newStatus) {
    if (newStatus >= 1 && newStatus <= 2) {
      _status = newStatus;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['status'] = _status;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Task.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    _status = map['status'];
    _date = map['date'];
  }
}
