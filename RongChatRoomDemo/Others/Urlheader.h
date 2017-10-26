

//用户注册
#define registUrl @"http://www.leaguecc.com:6660/user/phoneUserRegist"

//找回密码
#define resetPasswUrl @"http://www.leaguecc.com:6660/user/appforgetPassword"

//密码登陆
#define LoginPassUrl @"http://www.leaguecc.com:6660/user/appPhoneUserLoginpwd"



/*

 首页
 
 */

//获取轮播图
#define LunboUrl @"http://www.leaguecc.com:6660/news/appGetBreakNews"
//获取分析新闻
#define AnalyzeNewsUrl @"http://www.leaguecc.com:6660/news/appGetAnalyzeNews"
//获取资讯/news/pcGetFastNews
#define MessageNewsUrl @"http://www.leaguecc.com:6660/news/appGetMessageNews"
//获取快讯/news/appGetHotNews
#define MessageFastNewsUrl @"http://www.leaguecc.com:6661/news/getfastnewsiOS"
//获取热点新闻/news/appGetHotNews
#define MessageHotNewsUrl @"http://www.leaguecc.com:6660/news/appGetHotNews"





/*
 收藏模块
 /favoritesController/favoritesNews
 */
//新闻收藏列表
#define CollectionNewsList @"http://www.leaguecc.com:6660/favoritesController/queryFavoriteNews"
//判断是否收藏
#define ChargeCollection @"http://www.leaguecc.com:6660/favoritesController/queryIsNotFavorites"
//收藏
#define Collectionnews @"http://www.leaguecc.com:6660/favoritesController/favoritesNews"
//取消收藏
#define UnCollectionnews @"http://www.leaguecc.com:6660/favoritesController/removeFavoriteNews"

//视频收藏列表
#define CollectionVideoList @"http://www.leaguecc.com:6660/favritesVideoController/queryFavritesVideo"
//判断视频是否收藏
#define ChargeVideoCollection @"http://www.leaguecc.com:6660/favritesVideoController/favritesVideoExit"
//收藏视频
#define CollectionVideo @"http://www.leaguecc.com:6660/favritesVideoController/addFavritesVideo"
//取消收藏视频
#define UnCollectionVideo @"http://www.leaguecc.com:6660/favritesVideoController/removeFavritesVideo"






/*
 修改用户个人中心
 
 */

//修改用户信息
#define Updateusers @"http://www.leaguecc.com:6660/user/updateUser"
//修改用户密码user/modifyUserPassword
#define UpdatePassusers @"http://www.leaguecc.com:6660/user/modifyUserPassword"
//提交图片
#define updateImage @"http://www.leaguecc.com:6662/appuploadimg"



//新闻详情html
#define DetailnewsHTML @"http://www.leaguecc.com:6661/news/queryNewsById?id=%@"

// 搜索结果 /marketController/currencymarket
#define SearchUrl @"http://www.leaguecc.com:6660/searchNewsController/queryNewsByKey"

// 行情
#define HangqingUrl @"http://www.leaguecc.com:6660/marketController/currencymarket"

// 意见反馈
#define SuggestUrl @"http://www.leaguecc.com:6660/feedbackController/addFeedback"

//视频列表。
#define VideoListUrl @"http://www.leaguecc.com:6661/pastVideoController/queryPastVideo"

//直播列表。
#define LiveListUrl @"http://www.leaguecc.com:6660/liveStream/getLiveUrlAll"

//直播截图。
#define LivePicUrl @"http://www.leaguecc.com:6660/onlinePictureController/getOnlinePicture"

//直播人数。
#define LiveGetNumberUrl @"http://www.leaguecc.com:6660/onlineNumberController/getRealTimeChannelOnlineNumber"

//把视频被点击信息传给服务器
#define VideoCollectNum @"http://www.leaguecc.com:6661/pastVideoController/addCount"
//把新闻被点击信息传给服务器
#define NewsCollectNum @"http://www.leaguecc.com:6660/favoritesController/addNewsCount"


//日历
#define CancleDate @"http://www.leaguecc.com:6660/economicEventController/queryEventByDate"

//获取国籍图片
#define CountryPicUrl @"http://www.leaguecc.com:6661/country/%@.png"

//退出登录
#define QuartUrl @"http://www.leaguecc.com:6660/user/loginOutForApp"
//通过SecTion登录
#define SectionLoginUrl @"http://www.leaguecc.com:6660/user/getUserByUUidForApp"






