
class ApiConfig{

  // /// for Development
  static const String mediaBaseUrl =  '';
  static const String baseUrl =  '';
  /// Develop
  static const String signalRBaseUrl = "http://185.100.232.17:9080/api/Rosters"; // DEVELOPMENT
  static const String signalRUrl = "http://185.100.232.17:9080"; // DEVELOPMENT


  /// SQFLite Database
  static const String messageTableName = "messages";
  static const String requestTableName = "requests";

  ///SignalR
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
  static const String userId = '1001';
  static const String userName = 'client';

  // static List<LanguageModel> languages = [
  //   LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
  //   LanguageModel(languageName: 'German', countryCode: 'DE', languageCode: 'de'),
  // ];


  /// Bannerd Ad
  final adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Test Ad
  final nativePostAdUnitID = 'ca-app-pub-3940256099942544/2247696110';  //Test Ad

}
