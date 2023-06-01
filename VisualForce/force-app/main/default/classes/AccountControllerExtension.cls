public with sharing class AccountControllerExtension {

    public List<Contact> listContact {get; set;}
    List<Contact> listContactToDelete;
    public Account account {get; set;}

    public AccountControllerExtension(ApexPages.StandardController standardController) {
        this.account = standardController.getRecord() == null ? new Account(): (Account) standardController.getRecord();
        this.listContact = new List<Contact>();
        this.listContactToDelete = new List<Contact>();

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

        Contact con = this.listContact.remove(Integer.valueOf(index));

        if (con.Id != null) {
            listContactToDelete.add(con);
        }

        return null;
    }

    public Pagereference saveAccount(){
        upsert account;

        for (Contact contact : this.listContact) {
            contact.AccountId = account.Id;
        }

        upsert this.listContact;

        if(listContactToDelete.isEmpty()){
            delete this.listContactToDelete;
        }

        ApexPages.StandardController controller = new ApexPages.StandardController(account);

        return controller.view();
    }
}