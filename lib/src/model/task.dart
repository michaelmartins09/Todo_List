class Task{
  int id;
  String title;
  String subTitle;
  bool isFinished;

  Task({this.id, this.title, this.subTitle, this.isFinished = false});

  Map<String, dynamic> toMap(){
    return {
      'id': this.id,
      'title':this.title,
      'subTitle':this.subTitle,
      'isFinished':this.isFinished,
    };
  }

  @override
  String toString() {
    return "TaskModel => {$id, $title, $subTitle, $isFinished}";
  }
}