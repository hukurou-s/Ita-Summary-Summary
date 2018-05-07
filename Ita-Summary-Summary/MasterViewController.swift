//
//  MasterViewController.swift
//  Ita-Summary-Summary
//
//  Created by 石井怜央 on 2018/05/04.
//  Copyright © 2018 LEO. All rights reserved.
//

import UIKit

struct Article : Codable {
    var id: Int
    var name: String
    var url: String
    var date: String
    var board_id: Int
    var created_at: String
    var updated_at: String

    init() {
        id = 0
        name = ""
        url = ""
        date = ""
        board_id = 0
        created_at = ""
        updated_at = ""
    }
}

class MasterViewController: UITableViewController {



    var detailViewController: DetailViewController? = nil

    var articles: [Article] = []


    override func viewDidLoad() {
    super.viewDidLoad()
    getArticlesList()
    // Do any additional setup after loading the view, typically from a nib.
    navigationItem.leftBarButtonItem = editButtonItem

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    navigationItem.rightBarButtonItem = addButton

    if let split = splitViewController {
        let controllers = split.viewControllers
        detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
    }


    override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }


    @objc
    func insertNewObject(_ sender: Any) {
    //objects.insert(NSDate(), at: 0)
    articles.insert(Article(), at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)

    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let article = articles[indexPath.row] as! Article
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = article
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    }


    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if articles.count > 0 {
            cell.textLabel?.text = articles[indexPath.row].name
        }
        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return false

    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        articles.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }

    }

    func getArticlesList() {

        var articlesJSON: [Article] = []
        let APIUrl = "http://127.0.0.1:3000/articles"

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = URL(string: APIUrl) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
            }

            guard let jsonData = data else {
                session.invalidateAndCancel()
                return
            }
            let articlesJSON = try? JSONDecoder().decode([Article].self, from: jsonData)

            self.articles = articlesJSON!

        }

        task.resume()
    }


}
