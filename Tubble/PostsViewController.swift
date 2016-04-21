import UIKit

struct Post {
    let title: String
    let body: String
}

class PostTableViewCell : UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
}

class PostsViewController : UITableViewController {
    
    let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts")!
    
    var posts: [Post] = []
    
    @IBOutlet var loadingView: UIView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = loadingView
        loadingIndicator.startAnimating()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            
            guard let data = data where error == .None else { return }
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSDictionary]
            
            self.posts = json.map({
                Post(title: $0["title"] as! String, body: $0["body"] as! String)
            })
            
            dispatch_async(dispatch_get_main_queue()) {
                sleep(2)
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
                self.loadingIndicator.stopAnimating()
            }
        }
        
        task.resume()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.bodyLabel.text = post.body
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 128
    }
    
}
