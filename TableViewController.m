//
//  TableViewController.m
//  A&F
//
//  Created by Sresty Theegela on 5/25/16.
//  Copyright © 2016 icc. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"


@interface TableViewController ()


@property (strong, nonatomic) NSXMLParser *xmlParserObject;
@property (strong, nonatomic) NSString *element;
@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *descriptionArray;
@property (strong, nonatomic) NSString *descFooter;


@end

@implementation TableViewController


@synthesize xmlParserObject;
@synthesize titleArray;
@synthesize descriptionArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArray = [[NSMutableArray alloc]init];
    descriptionArray = [[NSMutableArray alloc]init];
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"https://news.google.com/?output=rss"];
    NSString *string1 = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    string1 = [string1 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string1 = [string1 stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string1 = [string1 stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
  //  string1 = [string1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
  //  string1 = [string1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
  //  string1 = [string1 stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
   
    NSLog(@"XXXXXX%@",string1);
    NSData *xmlData=[[NSData alloc]init];
    xmlData= [string1 dataUsingEncoding:NSUTF8StringEncoding];
    xmlParserObject =[[NSXMLParser alloc]initWithData:xmlData];
    [xmlParserObject setDelegate:self];
    [xmlParserObject parse];
  //  NSLog(@"%@",xmlParserObject)
    
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary<NSString *,
                NSString *> *)attributeDict{
    self.element = elementName;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string{
   
    if ([self.element isEqualToString:@"title"]) {
        string = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.header = string;
       [titleArray addObject:self.header];
       [titleArray removeObject:@"Top Stories - Google News"];
     //  NSLog(@"TitleArray:%@", titleArray);
    }
    
    if ([self.element isEqualToString:@"description"]) {
        
        string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
        NSString *string2 = string;
        NSRange range = [string2 rangeOfString:@""];
        self.descFooter = string;
        NSLog(@"Description:%@",string);
        [descriptionArray addObject:self.descFooter];
      //  NSLog(@"DescriptionArray:%@", descriptionArray);
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"title"]) {
        
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return titleArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Top Stories - Google News";
}
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return string;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = titleArray[indexPath.row];
    cell.detailTextLabel.text = descriptionArray[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
