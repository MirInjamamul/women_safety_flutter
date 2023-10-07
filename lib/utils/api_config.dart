
class ApiConfig{

  // /// for Development
  static const String mediaBaseUrl =  'http://185.100.232.17:8189';
  static const String baseUrl =  'http://185.100.232.17:8189/api';
  static const String signalRBaseUrl = "http://185.100.232.17:8080/api/Rosters";




  /// SQFLite Database
  static const String messageTableName = "messages";
  static const String requestTableName = "requests";
  ///SignalR
  static const String signalRUrl = "http://185.100.232.17:8080";
  static const String signalRChatHub = "/chathub";
  static const String getOnlineRoster = signalRBaseUrl+'/online/';
  static const String getSuggestionRoster = signalRBaseUrl+'/suggestion/';
  static const String getLastOnlineRoster = signalRBaseUrl+'/last_online';
  static const String changeFollowUserUri = signalRBaseUrl+'/follower/';
  static const String blockChatUserUri = signalRBaseUrl+'/blocklist';
  static const String getBlockUserUri = signalRBaseUrl+'/getBlockUser';
  static const String deleteBlockUserUri = signalRBaseUrl+'/blocklist';
  static const String getBlockByUri = '/userblock/userblockby/';


  static const String appName = 'Women safety';


  static const String token = 'token';

  // static List<LanguageModel> languages = [
  //   LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
  //   LanguageModel(languageName: 'German', countryCode: 'DE', languageCode: 'de'),
  // ];


  /// Bannerd Ad
  final adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Test Ad
  final nativePostAdUnitID = 'ca-app-pub-3940256099942544/2247696110';  //Test Ad

}
