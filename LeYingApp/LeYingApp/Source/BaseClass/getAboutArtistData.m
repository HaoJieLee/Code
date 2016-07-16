//
//  getAboutArtistData.m
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getAboutArtistData.h"
#import "expandModel.h"
#import "getActivityList.h"
#import "recommendModel.h"
#import "getArtists.h"
#import "detailModel.h"
#import "NotifyModel.h"
#import "SearchModel.h"

static getAboutArtistData *gad;

@implementation getAboutArtistData

+(instancetype)shareArtistData
{
    if (gad == nil)
    {
        //dispatch_once_t 用于检查该代码块是否已经被调度谓词
        //dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gad = [[getAboutArtistData alloc]init];
            
        });
    }
    return gad;

}
-(NSMutableArray*)SearchExpandWithType:(NSString *)location WithCategoryid:(NSString*)woid gender:(int)gender Category:(NSString*)category Sort:(int)sort PageNo:(int)pageno PageSize:(int)pagesize{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *string = [NSString stringWithFormat:@"location=%@&pageNo=%d&pageSize=%d&category=%@&gender=%d&sort=%d&word=%@",location,pageno,pagesize,category,gender,sort,woid];
    NSDictionary *dic = [self dictionaruWithUrl:string UrlString:@"/artist/search/artist/category"];
    NSArray *array1 = [dic objectForKey:@"data"];
    for (NSDictionary * dict in array1)
    {
        SearchModel * Search = [[SearchModel alloc] init];
        [Search setValuesForKeysWithDictionary:dict];
        [array addObject:Search];
    }
    return array;
    
    
}
- (NSDictionary*)dictionaruWithUrl:(NSString *)urlString UrlString:(NSString*)string{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,string];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSData *argDada = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}




-(void)getCategoryExpandWithType:(NSString *)pageno WithCategoryid:(NSString*)pagesize gender:(NSString* )gender Category:(NSString*)category Expand:(GetCategory)expand{
    self.categoryArr = [NSMutableArray new];
    NSString *string = [NSString stringWithFormat:@"pageNo=%@&pageSize=%@&category=%@",pageno,pagesize,category];
    NSDictionary *dic = [self dictionaruWithUrl:string UrlString:@"/announcement/announcementlist"];
    NSArray *array = [dic objectForKey:@"data"];
    for (NSDictionary * dict in array)
    {
        NotifyModel * m = [[NotifyModel alloc] init];
        [m setValuesForKeysWithDictionary:dict];
        [self.categoryArr addObject:m];
    }
    
    
    expand(self.categoryArr);

}

-(void)getNotifyExpandWithType:(int )pageno WithCategoryid:(int)pagesize City:(NSString *)city Category:(NSString*)category Expand:(GetNotifyList)ExpandValue{
    NSMutableArray *notifyArray = [[NSMutableArray alloc]init];
    NSString *string = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d&city=%@&category=%@",pageno,pagesize,city,category];
    NSDictionary *dic = [self dictionaruWithUrl:string UrlString:@"/announcement/announcementlist"];
    NSArray *array = [dic objectForKey:@"data"];
    for (NSDictionary * dict in array)
    {
        NotifyModel * m = [[NotifyModel alloc] init];
        [m setValuesForKeysWithDictionary:dict];
        [notifyArray addObject:m];
    }

    ExpandValue(notifyArray);
}

-(BOOL)judgeAboutArtist:(NSString *)myToken
{
    NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/can_apply_artist?token="];
    NSMutableString *str2 = [NSMutableString stringWithString:myToken];
    NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    BOOL str5 = [dictionary objectForKey:@"can"];
    
    return str5;
}

// 新版本艺人分类  通告列表
-(void)getArtistCategory:(GetArtistCategory)categoryValue
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/getcategory"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.categoryDic = dict;
    categoryValue(self.categoryDic);
    
    
    
}


#pragma mark 艺人中心轮播图
-(void)getArtistExpandWithType:(NSString *)actlunboType WithCategoryid:(NSString *)categoryid Expand:(GetArtistExpand)ExpandValue
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/index"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"banner=%@&announcement=%@",actlunboType,categoryid];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [[dict objectForKey:@"data"]objectForKey:@"banner"];
    
    self.myarr = [NSMutableArray array];
    for (NSDictionary * dict in arr)
    {
        expandModel * m = [[expandModel alloc] init];
        [m setValuesForKeysWithDictionary:dict];
        [self.myarr addObject:m];
    }

    
    
    
    
    
    ExpandValue(self.myarr);
}

//通告详情
-(void)getActivityListWithId:(NSString *)activityId Artivity:(GetArtivity)activityValue
{
    self.activityDic= [NSDictionary dictionary];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/announcement/detail"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",activityId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.activityDic = dict;

    activityValue(self.activityDic);
}

//获取全部艺术家 包括男女
-(void)getArtistsWithPage:(NSString *)page getId:(NSString *)artistId getManorWoman:(NSString *)sex ArtistValue:(GetArtistValue)ArtistValue
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/search/artist/category"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"page=%@&category=%@&gender=%@&pageSize=10",page,artistId,sex];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.detailDic = dict;
    
    
    ArtistValue(self.detailDic,page);
}
//单个艺人详情

-(void)getRecommendWithId:(NSString *)artistId Recommend:(GetRecommend)recommendValue
{
    self.recommendArr = [NSMutableArray new];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/Artist/detail"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",artistId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (![dict objectForKey:@"data"])
    {
        // 错误
        
    }
    else
    {
        NSArray *array = [NSArray arrayWithObjects:[dict objectForKey:@"data"], nil];
        for (NSDictionary *dic in array) {
            detailModel *detail = [[detailModel alloc]init];
            [detail setValuesForKeysWithDictionary:dic];
            [self.recommendArr addObject:detail];
        }
        
    }

    recommendValue(self.recommendArr);
}

-(BOOL)leyingCollectWithId:(NSString *)projectId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/index/leyingshoucang.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",projectId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"login"]] isEqualToString:@"0"])
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }
    else
    {
        if ([[[dict objectForKey:@"datas"] objectForKey:@"success"] isEqualToString:@"0"])
        {
            NSLog(@"%@---------",[[dict objectForKey:@"datas"] objectForKey:@"success"]);
            return NO;
        }
        else
        {
            NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"success"]);
            return YES;
        }
        
    }
    
    
    
    return nil;
    
    
}
-(void)artAddclick:(NSString *)myId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/yiren/yirenaddclick.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",myId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
//艺人收藏
-(BOOL)artistCollectWithId:(NSString *)artistId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/artistfavorite"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",artistId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([[[dict objectForKey:@"datas"] objectForKey:@"success"] isEqualToString:@"0"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
//    if ([[[dict objectForKey:@"datas"] objectForKey:@"success"] isEqualToString:@"1"])
//    {
//        NSLog(@"收藏成功");
//    }


}



-(void)getArtistPromote:(GetArtistPromote)promoteValue
{
    
}



-(NSMutableArray *)promoteArr
{
    if (_promoteArr == nil)
    {
        
        _promoteArr = [NSMutableArray array];
    }
    return _promoteArr;
}

-(NSMutableArray *)artistArr
{
    if (_artistArr == nil)
    {
        
        _artistArr = [NSMutableArray array];
    }
    return _artistArr;
}

-(NSMutableArray *)activityArr
{
    if (_activityArr == nil)
    {
        
        _activityArr = [NSMutableArray array];
    }
    return _activityArr;
}


-(NSDictionary *)categoryDic
{
    if (_categoryDic == nil)
    {
        
        _categoryDic = [NSDictionary dictionary];
    }
    return _categoryDic;
}


-(NSMutableArray *)myarr
{
    if (_myarr == nil)
    {
        
        _myarr = [NSMutableArray array];
    }
    return _myarr;
}



@end
