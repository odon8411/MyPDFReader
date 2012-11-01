//
//  RootViewController.m
//  MyPDFView
//
//  Created by oudongjia on 12-7-27.
//  Copyright 2012 z. All rights reserved.
//

#import "RootViewController.h"
#import "fileManager.h"
//#import "MyPDFViewController.h"
@implementation RootViewController


#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle

///*
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"文件列表";
	[fileManager savePDFFilesToDocuments];
	//return;
	fileNameArray = (NSArray*)[fileManager getFileNameList];
	//fileNameArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//*/

///*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}
//*/
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [fileNameArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [fileNameArray objectAtIndex:indexPath.row];
    
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
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	//#import "MyPDFViewController.h"
	
	//	if (HUD == nil) {
	//		HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
	//	}
	//	HUD.mode = MBProgressHUDModeIndeterminate;
	//	HUD.labelText = @"Loading file";
	//	HUD.customView = nil;
	//	[HUD show:YES];
	
	//	MyPDFViewController *PDFview = [[MyPDFViewController alloc] init];
	//	PDFview.fileName = [fileNameArray objectAtIndex:indexPath.row];
	//	[self.navigationController pushViewController:PDFview animated:NO];
	//	[PDFview release];
	
	
	NSString *documentName =  [fileNameArray objectAtIndex:indexPath.row];
	NSString *phrase = nil;
	ReaderDocument *document = [ReaderDocument unarchiveFromFileName:documentName password:phrase];
	
	if (document == nil) // We need to create a brand new ReaderDocument object the first time we run
	{
		NSString *filePath = [[NSBundle mainBundle] pathForResource:documentName ofType:nil]; // Path
		
		document = [[[ReaderDocument alloc] initWithFilePath:filePath password:phrase] autorelease];
	}
	
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
		
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
		
		[self.navigationController pushViewController:readerViewController animated:YES];
		
#else // present in a modal view controller
		
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
		
		[self presentModalViewController:readerViewController animated:YES];
		
#endif // DEMO_VIEW_CONTROLLER_PUSH
		
		[readerViewController release]; // Release the ReaderViewController
	}
	
}

#pragma mark ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
	
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
	
	[self.navigationController popViewControllerAnimated:YES];
	
#else // dismiss the modal view controller
	
	[self dismissModalViewControllerAnimated:YES];
	
#endif // DEMO_VIEW_CONTROLLER_PUSH
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

