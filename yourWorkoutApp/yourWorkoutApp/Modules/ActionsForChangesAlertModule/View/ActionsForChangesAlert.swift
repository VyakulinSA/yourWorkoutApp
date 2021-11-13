//
//  ActionsForChangesAlertVC.swift
//  YourFinances
//
//  Created by Вякулин Сергей on 27.09.2021.
//

import UIKit

protocol ActionsForChangesAlertOutput {
    func accept()
    func deleteChanges()
}

final class ActionsForChangesAlert: UIAlertController {
    
    private var output: ActionsForChangesAlertOutput!
    private var acceptTitle: String?
    private var deleteTitle: String?
    private var titleString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let acceptTitle = acceptTitle{
            let acceptAction = UIAlertAction(title: acceptTitle, style: .default) { [weak self] _ in
                self?.output.accept()
            }
            self.addAction(acceptAction)
        }

        if let deleteTitle = deleteTitle {
            let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive) { [weak self] _ in
                self?.output.deleteChanges()
            }
            self.addAction(deleteAction)
        }
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.addAction(cancelAction)
        
        self.title = titleString

    }
    
    func configure(output: ActionsForChangesAlertOutput, acceptTitle: String = "Accept change", deleteTitle: String? = "Delete change", titleString: String?){
        self.output = output
        self.acceptTitle = acceptTitle
        self.deleteTitle = deleteTitle
        self.titleString = titleString
    }

}
