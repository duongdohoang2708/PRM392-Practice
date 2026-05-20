class Settings{
  static final Settings _settingsInstance = Settings._settings();
  factory Settings(){
    return _settingsInstance;
  }
  Settings._settings();
}
void main(){
  var instance1 = Settings();
  var instance2 = Settings();
  var result = identical(instance1, instance2);
  print(result);
}