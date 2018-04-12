//
//  VodPlayer.h
//  VodSdk
//
//  Created by gs_mac_fjb on 14-10-31.
//  Copyright (c) 2014年 gensee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VodGLView.h"
#import "GSVodDocView.h"



typedef enum
{
    PNG_TYPE=1,
    SWF_TYPE=2,
}DOC_TYPE;


typedef enum
{
    SPEED_NORMAL,
    SPEED_125,
    SPEED_150,
    SPEED_175,
    SPEED_2,
    SPEED_25,
    SPEED_3,
    SPEED_35,
    SPEED_4
}SpeedValue;


@class GSVodDocView;

@class VodSdk,downItem;
@protocol VodPlayDelegate;

/**
 *  VodPlayer是管理播放点播件（录制件）的类
 */
@interface VodPlayer : NSObject

/**
 *  VodPlayDelegate代理
 */
@property(nonatomic,weak)id<VodPlayDelegate> delegate;

/**
 *  播放视频的View
 */
@property(nonatomic,strong)VodGLView *mVideoView;



/**
 *  显示SWF文档的View，默认为SWF文档
 */
@property(nonatomic,strong)GSVodDocView *docSwfView;


/**
 *  显示PNG文档的View
 */
@property(nonatomic,strong)UIView *vodDocShowView DEPRECATED_MSG_ATTRIBUTE("不再使用， 改为docSwfView");


@property(nonatomic,assign)int docType DEPRECATED_MSG_ATTRIBUTE("不再使用");

/**
 *  播放的点播项
 */
@property(nonatomic,strong)downItem *playItem;



/**
 *  设置文档文档的显示模式
 */
@property(assign,nonatomic)GSVodDocShowType  gSDocModeType;



/**
 是否采用硬件解码
 */
@property (assign, nonatomic) BOOL hardwareAccelerate;




#pragma mark - play


/**
 *  默认初始化
 *
 *  @return vodPlayer实例
 */
- (id)init;



/**
 在检测到3g/4g/wifi 切换时主调调用此方法发起重连
 */
- (void)reconnect;


/**
 *  离线播放
 *
 *  @param postChat 是否按照时间顺序依次推送聊天
 */
- (void)OfflinePlay:(BOOL)postChat;

/**
 *  在线播放
 *
 *  @param postChat 是否按照时间顺序依次推送聊天
 *  @param audioOnly YES将不会下载视频，只播放声音
 */
- (void)OnlinePlay:(BOOL)postChat audioOnly:(BOOL)audioOnly;


/**
 *  加速播放点播
 *
 *  @param value 播放速度
 */
- (void)SpeedPlay:(SpeedValue)value;

/**
 *  开关视频
 *
 *  @param close 开关视频
 */
- (void)closeVideo:(BOOL)close;

/**
 * 暂停
 */
- (void)pause;

/**
 *  恢复
 */
- (void)resume;

/**
 *  停止
 */
- (void)stop;

/**
 *  从当前位置开始播放
 *
 *  @param position 播放的位置
 *
 *  @return 结果是否成功，O表示成功
 */
- (int)seekTo:(int)position;


/**
 *  在视频窗口添加控件
 */
- (void)addSubViewOnVideoView:(id)subView;


/**
 * 获取问答列表和聊天列表
 */
- (void)getChatAndQalistAction DEPRECATED_MSG_ATTRIBUTE("建议使用getChatListWithPageIndex: 和 getQaListWithPageIndex:");


/**
 *  获取聊天，一次最多两百条，索引从1开始
 *
 *  @param pageIndex 当前页索引
 */
- (void)getChatListWithPageIndex:(int)pageIndex;


/**
 *  获取聊天，一次最多两百条， 索引从1开始
 *
 *  @param pageIndex 当前页索引
 */
- (void)getQaListWithPageIndex:(int)pageIndex;

/**
 *  重设音频播放器，在程序重新被激活时调用
 */
- (void)resetAudioPlayer;

/**
 设置AudioSession
 */
- (void)enableBackgroundMode;


/**
 * 清除音频队列里面未播放完的数据
 * 倍速播放开始和结束的时候 上层需要清空 未播放的缓存的音频队列
 */
-(void)cleanQueuedBuffersData;



@end

@protocol VodPlayDelegate <NSObject>

@optional


/**
 *  初始化VodPlayer代理,为了优化视频加载速度，不再等文档加载，所以此处的文档有可能还并未下载好，docInfos可能是空，随后会从onDocInfo:回调
 *
 *  @param result    初始化结果, 0: 成功； 0x0c: license满，请找相关人员（非技术）扩充点播并发；10015：已下载点播的文件不完整,
 *  @param haveVideo 是否含有视频
 *  @param duration  点播件（录制件）总长度，单位：毫秒
 *  @param docInfos  文档信息
 */
- (void) onInit:(int) result haveVideo:(BOOL)haveVideo duration:(int)duration docInfos:(NSArray*)docInfos ;

/**
 * 文档信息回调
 * @param docInfos 文档信息
 */
- (void)onDocInfo:(NSArray*)docInfos;

/**
 * 播放完成停止通知，
 */
- (void) onStop;

/**
 * 进度通知
 * @param position 当前播放进度
 */
- (void) onPosition:(int) position;

/**
 * 文档信息通知
 * @param position 当前播放进度，如果app需要显示相关文档标题，需要用positton去匹配onInit 返回的docInfos
 */
- (void) onPage:(int) position width:(unsigned int)width height:(unsigned int)height;

/**
 * 任意位置定位播放响应
 * @param position 进度变化，快进，快退，拖动等动作后开始播放的进度
 */
- (void) onSeek:(int) position ;

/**
 * 缓存通知
 * @param bBeginBuffer ture: 缓存结束  false:缓存开始
 */
- (void) OnBuffer:(BOOL)bBeginBuffer;



@optional

/*
 *监听video 的开始
 */
- (void) onVideoStart;


/**
 *  收到聊天
 *  按照时间顺序，获得聊天
 *  @param chatArray 聊天数据
 */
- (void) OnChat:(NSArray*)chatArray;



/**
 收到审核信息

 @param censorArray 审核信息，当 字典中的type字段为"msg" 则id表示单独某条消息的chatID， 若为"user",则id表示用户id
 */
- (void) OnChatCensor:(NSArray*)censorArray;


/*
 *获取聊天列表
 * 一次性获取所有聊天,最多两百条，如果more＝YES，再调用一次获取聊天的接口可获取下一页（最多200条）的聊天
 *@chatList   列表数据 (sender: 发送者  text : 聊天内容   time： 聊天时间)
 *
 */
- (void) vodRecChatList:(NSArray*)chatList more:(BOOL)more  currentPageIndex:(int)pageIndex;

/*
 *获取问题列表
 *@qaList   列表数据 （answer：回答内容 ; answerowner：回答者 ; id：问题id ;qaanswertimestamp:问题回答时间 ;question : 问题内容  ，questionowner:提问者 questiontimestamp：提问时间）
 *
 */
- (void) vodRecQaList:(NSArray*)qaList more:(BOOL)more currentPageIndex:(int)pageIndex;


/**
 * 音频电频值
 * @param level 电频大小
 */
- (void) onAudioLevel:(int) level;

//点播信息
- (void)onRecordInfo:(NSString*)storage duration:(NSString*)duration startTime:(NSString*)startTime;

@end



/**
 *  聊天消息类， 从OnChat回调
 */
@interface VodChatInfo : NSObject

/**
 *  发送者昵称
 */
@property (nonatomic, copy) NSString *senderName;

/**
 *  发送者ID
 */
@property (nonatomic, assign) NSUInteger senderID;

/**
 *  聊天内容富文本
 */
@property (nonatomic, copy) NSString *richText;


/**
 *  聊天内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  发送者角色值
 */
@property (nonatomic, assign) NSUInteger role;

/**
 *  相对播放时间的时间戳,单位毫秒
 */
@property (nonatomic, assign) float timestamp;

/**
 *  本条聊天的id
 */
@property (nonatomic, copy) NSString *chatid;


@end



