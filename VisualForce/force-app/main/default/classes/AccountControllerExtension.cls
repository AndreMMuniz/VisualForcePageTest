public with sharing class AccountControllerExtension {

    public List<Contact> listContact {get; set;}

    public AccountControllerExtension(ApexPages.StandardController standardController) {
        this.listContact = new List<Contact>();
    }

    public PageReference addContact(){
        this.listContact.add(new Contact());

        return null;
    }

    public Pagereference deleteContact(){
        String index = ApexPages.currentPage().getParameters().get('index');

        this.listContact.remove(Integer.valueOf(index));

        return null;
    }
}