

//用户注册
#define registUrl @"http://192.168.0.250:6660/user/phoneUserRegist"

//找回密码
#define resetPasswUrl @"http://192.168.0.250:6660/user/appforgetPassword"

//密码登陆
#define LoginPassUrl @"http://192.168.0.250:6660/user/appPhoneUserLoginpwd"



/*

 首页
 
 */

//获取轮播图
#define LunboUrl @"http://192.168.0.250:6660/news/appGetBreakNews"
//获取分析新闻
#define AnalyzeNewsUrl @"http://192.168.0.250:6660/news/appGetAnalyzeNews"
//获取资讯/news/pcGetFastNews
#define MessageNewsUrl @"http://192.168.0.250:6660/news/appGetMessageNews"
//获取快讯/news/appGetHotNews
#define MessageFastNewsUrl @"http://192.168.0.250.6661/news/getfastnewsiOS"
//获取热点新闻/news/appGetHotNews
#define MessageHotNewsUrl @"http://192.168.0.250:6660/news/appGetHotNews"





/*
 收藏模块
 /favoritesController/favoritesNews
 */
//新闻收藏列表
#define CollectionNewsList @"http://192.168.0.250:6660/favoritesController/queryFavoriteNews"
//判断是否收藏
#define ChargeCollection @"http://192.168.0.250:6660/favoritesController/queryIsNotFavorites"
//收藏
#define Collectionnews @"http://192.168.0.250:6660/favoritesController/favoritesNews"
//取消收藏
#define UnCollectionnews @"http://192.168.0.250:6660/favoritesController/removeFavoriteNews"

//视频收藏列表
#define CollectionVideoList @"http://192.168.0.250:6660/favritesVideoController/queryFavritesVideo"
//判断视频是否收藏
#define ChargeVideoCollection @"http://192.168.0.250:6660/favritesVideoController/favritesVideoExit"
//收藏视频
#define CollectionVideo @"http://192.168.0.250:6660/favritesVideoController/addFavritesVideo"
//取消收藏视频
#define UnCollectionVideo @"http://192.168.0.250:6660/favritesVideoController/removeFavritesVideo"






/*
 修改用户个人中心
 
 */

//修改用户信息
#define Updateusers @"http://192.168.0.250:6660/user/updateUser"
//修改用户密码user/modifyUserPassword
#define UpdatePassusers @"http://192.168.0.250:6660/user/modifyUserPassword"
//提交图片
#define updateImage @"http://192.168.0.250.6662/appuploadimg"



//新闻详情html
#define DetailnewsHTML @"http://192.168.0.250:6661/news/queryNewsById?id=%@"

// 搜索结果 /marketController/currencymarket
#define SearchUrl @"http://192.168.0.250:6660/searchNewsController/queryNewsByKey"

// 行情
#define HangqingUrl @"http://192.168.0.250:6660/marketController/currencymarket"

// 意见反馈
#define SuggestUrl @"http://192.168.0.250:6660/feedbackController/addFeedback"

//视频列表。
#define VideoListUrl @"http://192.168.0.250.6661/pastVideoController/queryPastVideo"

//直播列表。
#define LiveListUrl @"http://192.168.0.250:6660/liveStream/getLiveUrlAll"

//直播截图。
#define LivePicUrl @"http://192.168.0.250:6660/onlinePictureController/getOnlinePicture"

//直播人数。
#define LiveGetNumberUrl @"http://192.168.0.250:6660/onlineNumberController/getRealTimeChannelOnlineNumber"

//把视频被点击信息传给服务器
#define VideoCollectNum @"http://192.168.0.250.6661/pastVideoController/addCount"
//把新闻被点击信息传给服务器
#define NewsCollectNum @"http://192.168.0.250:6660/favoritesController/addNewsCount"


//日历
#define CancleDate @"http://192.168.0.250:6660/economicEventController/queryEventByDate"

//获取国籍图片
#define CountryPicUrl @"http://192.168.0.250.6661/country/%@.png"








