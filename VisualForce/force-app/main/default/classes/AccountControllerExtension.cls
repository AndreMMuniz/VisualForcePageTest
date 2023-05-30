public with sharing class AccountControllerExtension {

    public List<Contact> listContact {get; set;}
    public Account account {get; set;}

    public AccountControllerExtension(ApexPages.StandardController standardController) {
        this.listContact = new List<Contact>();
        this.account = standardController.getRecord() == null ? new Account(): (Account) standardController.getRecord();

        if (this.account.Id != null) {
            this.listContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId =: this.account.Id];
        }
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

    public Pagereference saveAccount(){
        upsert account;

        for (Contact contact : this.listContact) {
            contact.AccountId = account.Id;
        }

        upsert this.listContact;

        ApexPages.StandardController controller = new ApexPages.StandardController(account);

        return controller.view();
    }
}