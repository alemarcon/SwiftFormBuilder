//
//  ViewController.swift
//  FormBuilderSample
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import UIKit
import SwiftFormBuilder

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    private var formBuilder = FormBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadBuilder()
    }
    
    
    private func loadBuilder() {
        let items = loadSampleItems()
        
        formBuilder.set(items: items)
        formBuilder.delegate = self
        formBuilder.loadData(on: table)
        
    }
    
    fileprivate func loadSampleItems() -> [FormItem] {
        var items = [FormItem]()
        
        let textItem = FormItem(named: "nome", valueType: .firstname)
            .title("Nome utente")
            .placeholder("Inserisci il tuo nome")
            .isMandatory(true)
            .uiProperties(
                FormItemUIProperties(itemType: .textfield)
                    .keyboardType(.default)
                    .textFieldPropertie(
                        FormItemTextFieldProperty()
                            .cornerRadius(CGFloat(4))
                            .border(color: .white, width: .thin)
                            .leftPaggind(.large)
                        
                    )
            )
        
        items.append( textItem )
        
        let separatorItem = FormItem(named: "separator", valueType: .discardable)
            .uiProperties(
                FormItemUIProperties(itemType: .separator)
                    .elementColor(.lightGray)
            )
        
        items.append( separatorItem )
        
        let pickerItem = FormItem(named: "Valori", valueType: .text)
            .title("Picker")
            .placeholder("Seleziona valore")
            .uiProperties(
                FormItemUIProperties(itemType: .valuePicker)
                    .keyboardType(.default)
                    .textFieldPropertie(
                        FormItemTextFieldProperty()
                            .cornerRadius(CGFloat(4))
                            .border(color: .white, width: .thin)
                            .leftPaggind(.large)
                        
                    )
            )
            .pickerProperties(
                FormItemPickerProperties(doneButtonTitle: "Seleziona", cancelButtonTitle: "Annulla")
            )
            .pickerValues(values:[
                PickerValue(title: "Carbonara", value: "1"),
                PickerValue(title: "Amatriciana", value: "2"),
                PickerValue(title: "Gricia", value: "3")
            ])
        
        items.append( pickerItem )
        
        // This is only for demo porpouse. This object should be recovered by API call
        var policy = PolicyModel()
        policy.id = "id"
        policy.isAccepted = false
        policy.isRequired = true
        
        let linkItem = FormItem(named: "linkItem", valueType: .checkbox)
            .title("Collegati su vetrya web site", underlined: "vetrya web site")
            .link( URL(string: "https://www.vetrya.com/it") )
            .isMandatory(policy.isRequired)
            .policy(policy)
            .uiProperties(
                FormItemUIProperties(itemType: .link)
                    .textColor(.white)
                    .underlinedColor(.yellow)
            )
        
        items.append( linkItem )
        
        let dateItem = FormItem(named: "dateItem", valueType: .date)
            .title("Seleziona la data")
            .placeholder("Data di nascita")
            .isMandatory(true)
            .uiProperties(
                FormItemUIProperties(itemType: .datePicker)
                    .textFieldPropertie(
                        FormItemTextFieldProperty()
                            .cornerRadius(CGFloat(4))
                            .border(color: .white, width: .thin)
                            .leftPaggind(.large)   
                    )
            )
            .pickerProperties(
                FormItemPickerProperties(doneButtonTitle: "Seleziona", cancelButtonTitle: "Annulla")
                    .avoidLegalAge(true)
            )
        
        items.append( dateItem )
        
        
        let checkbox = FormItem(named: "checkboxItem", valueType: .checkbox)
            .title("Questo è un campo checkbox")
            .uiProperties(
                FormItemUIProperties(itemType: .checkbox)
                    .textColor(.white)
            )
        
        items.append( checkbox )
        
        
        let labelled = FormItem(named: "labelItem", valueType: .discardable)
            .value("Questo è un campo di solo testo. Usato per inserire una descrizione, un messaggio o una informazione particolare a cui non corrisponde nessuna azione.")
            .uiProperties(
                FormItemUIProperties(itemType: .text)
                    .textColor(.white)
                    .fontSize(CGFloat(17))
                    .alignment(.center)
            )
        
        items.append( labelled )
        
        let passwordItem = FormItem(named: "passwordItem", valueType: .password)
            .title("Password")
            .placeholder("Inserisci la tua password")
            .isMandatory(true)
            .passwordRules(FormItemPasswordProperty()
                            .minLength(3)
                            //.maxLength(15)
                            //.needUppercasedLetters(true)
                            //.needNumber(false)
            )
            .uiProperties(
                FormItemUIProperties(itemType: .textfield)
                    .keyboardType(.default)
                    .textFieldPropertie(
                        FormItemTextFieldProperty()
                            .cornerRadius(CGFloat(4))
                            .border(color: .white, width: .thin)
                            .leftPaggind(.large)
                    )
            )
        
        items.append( passwordItem )
        
        let buttonItem = FormItem(named: "button", valueType: .discardable)
            .title("VALIDATE")
            .uiProperties(
                FormItemUIProperties(itemType: .button)
                    .buttonPropertie(
                        FormItemButtonProperty()
                            .backgroundColor(.clear)
                            .titleColor(.red)
                            .border(width: 2, color: .yellow)
                            .radius(.medium)
                    )
            )
        
        items.append( buttonItem )
        
        return items
    }
}


extension ViewController: FormBuilderDelegate {
    
    func formItemsValidationSuccess(items: [ValidatedItem]) {
        print("Form validated")
    }
}
