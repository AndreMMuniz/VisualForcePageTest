public with sharing class AccountControllerExtension {

    public List<Contact> listContact {get; set;}

    public AccountControllerExtension(ApexPages.StandardController standardController) {
        this.listContact = new List<Contact>();
    }

    public PageReference addContact(){
        this.listContact.add(new Contact());

        return null;
    }
}