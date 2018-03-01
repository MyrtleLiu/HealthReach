//
//  syncDaily.m
//  mHealth
//
//  Created by gz dev team on 14年8月12日.
//
//

#import "syncDaily.h"
#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import "Alarm.h"

#import "NSNotificationCenter+MainThread.h"
#import"GDataXMLNode.h"


@implementation syncDaily

+(void)getHistoryRecord{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSLog(@"session_id=%@",session_id);
        NSLog(@"login_id=%@",login_id);
        NSString *url_string = [[NSString alloc]init];
        url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
        url_string = [url_string stringByAppendingString:@"healthReminder?login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        url_string = [url_string stringByAppendingString:@"&action=R"];
        
        //     NSString *   url_stringNew= [ url_string  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //
        //        NSURL *request_url = [NSURL URLWithString:url_stringNew];
        //         NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        //      //  NSLog(@"%@.",request_url);
        //        NSLog(@"%@",xmlData);
        //        if (xmlData == nil)
        //        {
        //            NSLog(@"Get Dairy History error!");
        //        } else
        //        {
        //            [self parsedDataFromData:xmlData];
        //        }
        //    }
        //
        
        NSString* webName =[[Constants getAPIBase2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString* webName2 =[login_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString* webName3 =[session_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString * url_string2=[[NSString alloc ] initWithFormat:@"%@healthReminder?login=%@&sessionid=%@&action=R",webName,webName2,webName3];
        NSLog(@"%@",url_string2);
        
        NSString * url_string3=[url_string2 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //    NSData *tempData=[url_string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *request_url = [NSURL URLWithString:url_string3];
      //  NSLog(@"NSURL=%@",request_url);
        
        //   NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        NSData *xmlData=[NSData dataWithContentsOfURL:request_url];
        
        
        //  NSLog(@"%@.",request_url);  kCFStringEncodingGB_18030_2000
    //    NSLog(@"%@__>>><<<<<>><><><>___________",xmlData);
        
        if (xmlData == nil)
        {
            NSLog(@"Get Dairy History error!");
        }
        else
        {
            [self parsedDataFromData:xmlData];
        }
    }
  

      
}
+(void)parsedDataFromData:(NSData *)xmlData{
    //   NSLog(@"%@____________",xmlData);
    
    NSString *xmlSTr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    //  NSLog(@"%@====================",xmlSTr);
    //NSData *daTA=[str000 dataUsingEncoding:NSUTF8StringEncoding];
    //   DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    GDataXMLDocument*doc= [[GDataXMLDocument alloc] initWithXMLString:xmlSTr options:0 error:nil];
    //NSLog(@"%@=++++++++++++",doc);
    
    NSArray *allArray=[doc  nodesForXPath:@"response" error:nil];
    NSLog(@" allArray= %@",allArray);
    
    
    NSString * str=[[NSString alloc]initWithFormat:@"%@",allArray];
   // NSLog(@"___+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+__+_+_+_+_+_+_%d,%@",[str length],allArray);
    if ([str length]<100)
    {
        NSLog(@"Error Error Error");
    }
    else
    {
        NSMutableArray *otherIDArray=[NSMutableArray new];
        NSMutableArray *otherStartTimeArray=[NSMutableArray new];
        NSMutableArray *otherEndTimeArray=[NSMutableArray new];
        NSMutableArray *otherTitleArray=[NSMutableArray new];
        NSMutableArray *otherNoteArray=[NSMutableArray new];
        NSMutableArray *otherDateDateArray=[NSMutableArray new];
        
        for( GDataXMLElement *otherElement in allArray)
        {
         //   NSLog(@"otherElement=%@",otherElement);
         //   NSDictionary *dic=[[otherElement elementsForName:@"adhoc"] objectAtIndex:0];
           // NSLog(@"dicdicdic=%@",dic);
            GDataXMLElement *adhocElement=[[otherElement elementsForName:@"adhoc"] objectAtIndex:0];
            
            NSArray* arrayHoc=[adhocElement children];
         //   NSLog(@" arrayHoc arrayHoc%@",arrayHoc);
           // NSLog(@"%d",arrayHoc.count);
            NSString * arrayHocLenger=[[NSString alloc]initWithFormat:@"%@",arrayHoc];
            if ([arrayHocLenger length]>100)
            {
                for (int i=0; i<arrayHoc.count; i++)
                {
                    GDataXMLElement * otherReminder=[arrayHoc objectAtIndex:i];
                    
                    GDataXMLElement * otherId=[[otherReminder elementsForName:@"id"]objectAtIndex:0];
                    NSString *idText=[otherId stringValue];
                    NSLog(@"%@",idText);
                    [otherIDArray addObject:idText];
                    
                    GDataXMLElement * otherStart=[[otherReminder elementsForName:@"time"]objectAtIndex:0];
                    NSString *startText=[otherStart stringValue];
                    [otherStartTimeArray addObject:startText];
                    
                    GDataXMLElement * otherEnd=[[otherReminder elementsForName:@"endtime"]objectAtIndex:0];
                    NSString *endText=[otherEnd stringValue];
                    [otherEndTimeArray addObject:endText];
                    
                    GDataXMLElement *otherTitle=[[otherReminder elementsForName:@"title"]objectAtIndex:0];
                    NSString *titleText=[otherTitle stringValue];
                    [otherTitleArray addObject:titleText];
                    
                    GDataXMLElement *otherNote=[[otherReminder elementsForName:@"note"]objectAtIndex:0];
                    NSString *noteText=[otherNote stringValue];
                    [otherNoteArray addObject:noteText];
                    
                    GDataXMLElement *otherDateDate=[[otherReminder elementsForName:@"startdate"]objectAtIndex:0];
                    NSString *dateDateText=[otherDateDate stringValue];
                    [otherDateDateArray addObject:dateDateText];
                    
                    GDataXMLElement *typeother=[[otherReminder elementsForName:@"type"]objectAtIndex:0];
                    GDataXMLElement *createtimeOther=[[otherReminder elementsForName:@"createtime"]objectAtIndex:0];
                    GDataXMLElement *servertimeOther=[[otherReminder elementsForName:@"servertime"]objectAtIndex:0];
                    
                    Alarm * alarm=[[Alarm alloc]initWithOthersId:[otherId stringValue] Title:[otherTitle stringValue] StartTime:[otherStart stringValue] EndTime:[otherEnd stringValue] Note:[otherNote stringValue] Date:[otherDateDate stringValue] Type:[typeother stringValue] Createtime:[createtimeOther stringValue] Servertime:[servertimeOther stringValue]];
                    [DBHelper addCalendarRoadOthers:alarm];
                    
                }
                
            }        }
       // NSLog(@"otherArray.count=%d otherArray=%@",[otherIDArray count],otherIDArray);
       // NSLog(@"otherStartTimeArray.count=%d otherStartTimeArray=%@",[otherStartTimeArray count],otherStartTimeArray);
      //  NSLog(@"otherEndTimeArray.count=%d otherEndTimeArray=%@",[otherEndTimeArray count],otherEndTimeArray);
       // NSLog(@"otherTitleArray.count=%d otherTitleArray=%@",[otherTitleArray count],otherTitleArray);
      //  NSLog(@"otherNoteArray.count=%d otherNoteArray=%@",[otherNoteArray count],otherNoteArray);
    
        
 
        
        
        
        
        
        
        
        
        NSMutableArray * medidArray=[NSMutableArray new];
        NSMutableArray *titleArrayMedication=[NSMutableArray new];
        NSMutableArray *dosageArray=[NSMutableArray new];
        NSMutableArray *reminderArrayMedication=[NSMutableArray new];
        NSMutableArray *mealArray=[NSMutableArray new];
        NSMutableArray *imgArray=[NSMutableArray new];
        NSMutableArray *noteArray=[NSMutableArray new];
        for (GDataXMLElement  * medicationOBject in allArray)
        {
            GDataXMLElement*medicationElement=[[medicationOBject elementsForName:@"medications"]objectAtIndex:0];
//            NSString*medicationStr=[medicationElement stringValue];
//            NSLog(@"-----&&&&s-%@",medicationStr);
            NSArray *arrayMedications=[medicationElement children];
          //  NSLog(@"arrayMedications=%@",arrayMedications);
            NSString*_arrayLongStr=[[NSString alloc]initWithFormat:@"%@",arrayMedications];
            if ([_arrayLongStr length]>100)
            {
                for (int i=0; i<arrayMedications.count; i++) {
                    
                    
                    
                    
                   // NSLog(@"_arraykfsaf=======%d",[_arrayLongStr length]);
                    
                    GDataXMLElement *medications=[arrayMedications objectAtIndex:i];
                    
                    GDataXMLElement *medid=[[medications elementsForName:@"medid"]objectAtIndex:0];
                    NSString *medidText=[medid stringValue];
                    [medidArray addObject:medidText];
                    
                    GDataXMLElement *titleMedication=[[medications elementsForName:@"title"]objectAtIndex:0];
                    NSString * titleText=[titleMedication stringValue];
                    [titleArrayMedication addObject:titleText];
                    
                    GDataXMLElement * dosage=[[medications elementsForName:@"dosage"]objectAtIndex:0];
                    NSString * dosageText=[dosage stringValue];
                    [dosageArray addObject:dosageText];
                    
                    GDataXMLElement * meal=[[medications elementsForName:@"meal"]objectAtIndex:0];
                    NSString * mealText=[meal stringValue];
                    [mealArray addObject:mealText];
                 //   NSLog(@"mealTEXt=%@",mealText);
                    GDataXMLElement *img=[[medications elementsForName:@"img"]objectAtIndex:0];
                    
             
                //    NSLog(@"[img stringValue]=%@",[img stringValue]);
             NSString * imgText =[[img stringValue]stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                  //   NSLog(@"imText=%@",imgText);
                    [imgArray addObject:imgText];
                     GDataXMLElement  *note=[[medications elementsForName:@"note"]objectAtIndex:0];
                    NSString *noteText=[note stringValue];
                  //  NSLog(@"notrnotr=%@",noteText);
                    if ([noteText isEqualToString:@""]||noteText==nil||noteText==NULL)
                    {
                     noteText=@"";
                    }
                    [noteArray addObject:noteText];
              //     NSLog(@"noteArray=%@",noteArray);
                    
                    
                    GDataXMLElement *servertimeElement=[[medications elementsForName:@"servertime"]objectAtIndex:0];
                    GDataXMLElement *reminders=[[medications elementsForName:@"reminders"]objectAtIndex:0];
                    NSLog(@"reminders=%@",reminders);
                    NSArray *remindersArray=[reminders children];
                    NSLog(@"remindersArray=%@",remindersArray);
                    NSString *reminderStr=[[NSString alloc] init];
                    NSString *reminderID=[[NSString alloc]init];
                    NSString *reminderType=[[NSString alloc]init];
                    NSString *reminderrepeat=[[NSString alloc]init];
                    NSString *reminderticken=[[NSString alloc]init];
                    NSString *remindercreatetime=[[NSString alloc]init];
                    NSString *reminderservertime=[[NSString alloc]init];
                
                    for (int j=0; j<remindersArray.count; j++)
                    {
                        GDataXMLElement *remindersMedercation=[remindersArray objectAtIndex:j];
                      //  NSLog(@"remindersMedercation==%@",remindersMedercation);
                     //   NSLog(@"[remindersMedercation stringValue] length]=%d",[[remindersMedercation stringValue] length]);
                        if ([[remindersMedercation stringValue] length]>40)
                            {
                                GDataXMLElement *timeReminderMedication=[[remindersMedercation elementsForName:@"time"]objectAtIndex:0];
//                                NSLog(@"timeReminderMedication=%@",timeReminderMedication);
//                                NSLog(@"2321312321321");
                            NSString *timeText=[timeReminderMedication stringValue];
                            NSString *timeText2=[[NSString alloc]initWithFormat:@"%@ ",timeText];
                            reminderStr = [reminderStr stringByAppendingString:timeText2];
                            
                            GDataXMLElement * idReminderMedication=[[remindersMedercation elementsForName:@"id"]objectAtIndex:0];
                            NSString *idText=[[NSString alloc]initWithFormat:@"%@ ",[idReminderMedication stringValue]];
                            reminderID =[reminderID stringByAppendingString:idText];
                            
                            GDataXMLElement * typeReminderMedication=[[remindersMedercation elementsForName:@"type"]objectAtIndex:0];
                            NSString *typeText=[[NSString alloc]initWithFormat:@"%@ ",[typeReminderMedication stringValue]];
                            reminderType=[reminderType stringByAppendingString:typeText];
                            
                            GDataXMLElement *repeatReminderMedication=[[remindersMedercation elementsForName:@"repeat"]objectAtIndex:0];
                            NSString *repeatText=[[NSString alloc]initWithFormat:@"%@ ",[repeatReminderMedication stringValue]];
                            reminderrepeat =[reminderrepeat stringByAppendingString:repeatText];
                            
                            GDataXMLElement * tickenReminderMedication=[[remindersMedercation elementsForName:@"ticken"]objectAtIndex:0];
                            NSString *tickenText=[[NSString alloc]initWithFormat:@"%@ ",[tickenReminderMedication stringValue] ];
                            reminderticken=[reminderticken stringByAppendingString:tickenText];
                            
                            GDataXMLElement *createtimeReminderMedication=[[remindersMedercation elementsForName:@"createtime"]objectAtIndex:0];
                            NSString* createtimeText=[[NSString alloc] initWithFormat:@"%@ ",[createtimeReminderMedication stringValue]];
                            remindercreatetime=[remindercreatetime stringByAppendingString:createtimeText];
                            
                            GDataXMLElement *servertimeReminderMedication=[[remindersMedercation elementsForName:@"servertime"]objectAtIndex:0];
                            NSString *servertimeText=[[NSString alloc] initWithFormat:@"%@ ",[servertimeReminderMedication stringValue]];
                            reminderservertime=[reminderservertime stringByAppendingString:servertimeText];
                        }
                        else
                        {
                            reminderStr=@"";
                            reminderservertime=@"";
                            reminderID=@"";
                            reminderType=@"";
                            reminderticken=@"";
                            remindercreatetime=@"";
                            reminderrepeat=@"";
                        
                        }
                    }
                    Alarm *alarm=[[Alarm alloc]initWithMedicationId:[medid stringValue] Title:[titleMedication stringValue] Meal:[meal stringValue] DosAge:[dosage stringValue] Servertime:[servertimeElement stringValue] ReminderTime:reminderStr ReminderID:reminderID ReminderType:reminderType ReminderRepeat:reminderrepeat ReminderTicken:reminderticken ReminderCreateTime:remindercreatetime ReminderserverTime:reminderservertime ReminderImageString:imgText Note:noteText];
#pragma malk ---update
                    
                    [DBHelper addCalendarRoadMedication:alarm];
                    [DBHelper addCalendarRoadMedication_Notes:alarm];
                 
                    [reminderArrayMedication addObject:reminderStr];
                    
                }
                
                
            }
            
            
            
        }
        
        //NSLog(@"medidArray=%@ count=%d",medidArray,medidArray.count);
       // NSLog(@"titleArrayMedication=%@ count=%d",titleArrayMedication,titleArrayMedication.count);
       // NSLog(@"dosageArray==%@, count=%d",dosageArray,dosageArray.count);
      //  NSLog(@"reminderArrayMedication=%@ count=%d",reminderArrayMedication,reminderArrayMedication.count);
       // NSLog(@"mealArray=%@,mealArray.count=%d",mealArray,mealArray.count);
        

        
        
        
        
        
        
        
        NSMutableArray * timeArrayWalking=[NSMutableArray new];
        
        for (GDataXMLElement * walkObject in allArray)
        {
            GDataXMLElement * walkElement=[[walkObject elementsForName:@"walking"]objectAtIndex:0];
            NSLog(@"walking=%@",walkElement);
            NSString *walkingStr=[walkElement stringValue];
            if (walkingStr !=nil) {
                NSLog(@"walkingStr=%@",walkingStr);
                NSArray *walking=[walkElement children];
                NSString * walkingArrayLength=[[NSString alloc]initWithFormat:@"%@",walking];
                if ([walkingArrayLength length]>100) {
                    for (int i=0; i<walking.count; i++)
                    {
                        GDataXMLElement *walkDDXmlElement=[walking objectAtIndex:i];
                        GDataXMLElement *idWalkElement=[[walkDDXmlElement elementsForName:@"id"]objectAtIndex:0];
                        GDataXMLElement *typeWalkElement=[[walkDDXmlElement elementsForName:@"type"]objectAtIndex:0];
                        GDataXMLElement *timeWalkElement=[[walkDDXmlElement elementsForName:@"time"]objectAtIndex:0];
                        GDataXMLElement *repeatWalkElement=[[walkDDXmlElement elementsForName:@"repeat"]objectAtIndex:0];
                        GDataXMLElement *createtimeWalkElement=[[walkDDXmlElement elementsForName:@"createtime"]objectAtIndex:0];
                        GDataXMLElement *servertimeWalkElement=[[walkDDXmlElement elementsForName:@"servertime"]objectAtIndex:0];
                        NSString * timeWalkText=[timeWalkElement stringValue];
                        NSLog(@"timeWalkText==%@",timeWalkText);
                        [timeArrayWalking addObject:timeWalkText];
                        GDataXMLElement *startText=[[walkDDXmlElement elementsForName:@"startdate"]objectAtIndex:0];
                        NSString*walkStartDate=[startText stringValue];
                        GDataXMLElement *endText=[[walkDDXmlElement elementsForName:@"enddate"]objectAtIndex:0];
                       NSString * walkEndDate=[endText stringValue];
                        NSLog(@"%@,%@",walkStartDate,walkEndDate);
                        
                        
                        Alarm *alarm=[[Alarm alloc]initWithWalkingId:[idWalkElement stringValue] StartDate:[startText stringValue] EndDate:[endText stringValue] Type:[typeWalkElement stringValue] Time:[timeWalkElement stringValue] Repeat:[repeatWalkElement stringValue] CreateTime:[createtimeWalkElement stringValue] Servertime:[servertimeWalkElement stringValue]];
                        [DBHelper addCalendarRoadWalking:alarm];
                    }
                   
                    
                }
            }
            
        }
        
        NSMutableArray * bloodpressueMutableArray=[[NSMutableArray alloc]init];
        NSMutableArray * ecgMutableArray=[[NSMutableArray alloc]init];
        NSMutableArray * glucoseMutableArray=[[NSMutableArray alloc]init];
        
        
        for (GDataXMLElement *ecgObject in allArray)
        {
            GDataXMLElement *ecgElement=[[ecgObject elementsForName:@"ecg"]objectAtIndex:0];
            NSString * ecgStr=[ecgElement stringValue];
            if (ecgStr)
            {
                NSLog(@"ecgstr=%@",ecgStr);
                NSArray *ecgArray=[ecgElement children];
                NSLog(@"ecgArray=%@",ecgArray);
                NSString *ecgArrayLenger=[[NSString alloc]initWithFormat:@"%@",ecgArray];
                if ([ecgArrayLenger length]>100)
                {
                    for (int i=0; i<ecgArray.count; i++)
                    {
                        //
                        GDataXMLElement * ecgDDxmlElemment=[ecgArray objectAtIndex:i];
                        GDataXMLElement * idECGElement=[[ecgDDxmlElemment elementsForName:@"id"]objectAtIndex:0];
                        GDataXMLElement * typeECGElement=[[ecgDDxmlElemment elementsForName:@"type"]objectAtIndex:0];
                        GDataXMLElement * timeECGElement=[[ecgDDxmlElemment elementsForName:@"time"]objectAtIndex:0];
                        GDataXMLElement * repeatECGElement=[[ecgDDxmlElemment elementsForName:@"repeat"]objectAtIndex:0];
                        GDataXMLElement * createtimeECGElement=[[ecgDDxmlElemment elementsForName:@"createtime"]objectAtIndex:0];
                        GDataXMLElement * servertimeECGElement=[[ecgDDxmlElemment elementsForName:@"servertime"]objectAtIndex:0];
                        
                        NSString *timeEcgText=[timeECGElement stringValue];
                        NSLog(@"TimeECGText%@",timeEcgText);
                        [ecgMutableArray addObject:timeEcgText];
                        
                        Alarm *alarm=[[Alarm alloc]initWithECGId:[idECGElement stringValue] ecgRepeat:[repeatECGElement stringValue] ecgtime:[timeECGElement stringValue] ecgtype:[typeECGElement stringValue] ecgcreatetime:[createtimeECGElement stringValue] ecgservertime:[servertimeECGElement stringValue]];
                        [DBHelper addCalendarRoadECG:alarm];
                    }
                 
                }
                
            }
        }
        
        for ( GDataXMLElement *bloodObject in allArray)
        {
            GDataXMLElement *bloodElemenr=[[bloodObject elementsForName:@"bloodpressue"]objectAtIndex:0];
            NSLog(@"bloodpressue=%@",bloodElemenr);
            NSString* bloodStr=[bloodElemenr stringValue];
            if (bloodStr!=nil) {
                NSLog(@"bloodStr=%@",bloodStr);
                NSArray *bloodArray=[bloodElemenr children];
                NSString *bloodArrayLength=[[NSString alloc]initWithFormat:@"%@",bloodArray];
                if ([bloodArrayLength length]>100) {
                    for (int i =0; i<bloodArray.count; i++) {
                        
                        GDataXMLElement * bloodDDxmlElement=[bloodArray objectAtIndex:i];
                        GDataXMLElement * idBloodElement=[[bloodDDxmlElement elementsForName:@"id"]objectAtIndex:0];
                        GDataXMLElement * typeBloodElement=[[bloodDDxmlElement elementsForName:@"type"]objectAtIndex:0];
                        GDataXMLElement * timeBloodElement=[[bloodDDxmlElement elementsForName:@"time"]objectAtIndex:0];
                        GDataXMLElement * repeatBloodElement=[[bloodDDxmlElement elementsForName:@"repeat"]objectAtIndex:0];
                        GDataXMLElement * createtimeBloodElement=[[bloodDDxmlElement elementsForName:@"createtime"]objectAtIndex:0];
                        GDataXMLElement * servertimeBloodElement=[[bloodDDxmlElement elementsForName:@"servertime"]objectAtIndex:0];
                        NSString *timeBloodText=[timeBloodElement stringValue];
                        NSLog(@"TimeECGText%@",timeBloodText);
                        [bloodpressueMutableArray addObject:timeBloodText];
                        Alarm *alarm=[[Alarm alloc]initWithBPId:[idBloodElement stringValue] bpRepeat:[repeatBloodElement stringValue] bptime:[timeBloodElement stringValue] bptype:[typeBloodElement stringValue] bpcreatetime:[createtimeBloodElement stringValue] bpservertime:[servertimeBloodElement stringValue]];
                        
                        [DBHelper addCalendarRoadBP:alarm];
                        
                    }
                  
                }
            }
            
        }
        
        for (GDataXMLElement *glucoseObject in allArray) {
            
            
            GDataXMLElement *glucoseElemenr=[[glucoseObject elementsForName:@"glucose"]objectAtIndex:0];
            NSLog(@"glucose=%@",glucoseElemenr);
            NSString* glucoseStr=[glucoseElemenr stringValue];
            if (glucoseStr) {
                NSLog(@"glucoseStr=%@",glucoseStr);
                NSArray *glucoseArray=[glucoseElemenr children];
                NSString * glucoseArrayLength=[[NSString alloc]initWithFormat:@"%@",glucoseArray];
                if ([glucoseArrayLength length]>100) {
                    for (int i =0; i<glucoseArray.count; i++)
                    {
                        GDataXMLElement *glucoseDDxmlElement=[glucoseArray objectAtIndex:i];
                        GDataXMLElement * idglucoseElement=[[glucoseDDxmlElement elementsForName:@"id"]objectAtIndex:0];
                        GDataXMLElement * typeglucoseElement=[[glucoseDDxmlElement elementsForName:@"type"]objectAtIndex:0];
                        GDataXMLElement * timeglucoseElement=[[glucoseDDxmlElement elementsForName:@"time"]objectAtIndex:0];
                        GDataXMLElement * repeatglucoseElement=[[glucoseDDxmlElement elementsForName:@"repeat"]objectAtIndex:0];
                        GDataXMLElement * createtimeglucoseElement=[[glucoseDDxmlElement elementsForName:@"createtime"]objectAtIndex:0];
                        GDataXMLElement * servertimeglucoseElement=[[glucoseDDxmlElement elementsForName:@"servertime"]objectAtIndex:0];
                        NSString *timeglucoseText=[timeglucoseElement stringValue];
                        NSLog(@"TimeECGText%@",timeglucoseText);
                        [glucoseMutableArray addObject:timeglucoseText];
                        Alarm *alarm=[[Alarm alloc]initWithBGId:[idglucoseElement stringValue] bgRepeat:[repeatglucoseElement stringValue] bgtime:[timeglucoseElement stringValue] bgtype:[typeglucoseElement stringValue] bgcreatetime:[createtimeglucoseElement stringValue] bgservertime:[servertimeglucoseElement stringValue]];
                        [DBHelper addCalendarRoadBG:alarm];
                        
                    }
                    
                    
                }
            }
        }
        
        
    }
    
}




@end
