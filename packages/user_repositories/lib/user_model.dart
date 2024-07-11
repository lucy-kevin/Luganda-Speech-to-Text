class UserModel{
  final String? id;
  final String title;
  final String notes;

  const UserModel({
    this.id,
    required this.title,
    required this.notes, 
  });

  toJson(){
    return {
      "Title": title,
      "Notes": notes,
    };
  }
}