public class ViewAccountDetailController {

    Id accountId;
    public List<Contact> listContact {get; set;}
    public Boolean isEditMode {get; set;}

    public ViewAccountDetailController(ApexPages.StandardController standardController) {
        this.accountId = standardController.getId();
        this.listContact = getContacts();
        this.isEditMode = false;
    }

    public List<Contact> getContacts(){
        return [SELECT ID, FIRSTNAME, LASTNAME, EMAIL FROM CONTACT WHERE ACCOUNTID =: this.accountId];
    }

    public Pagereference newContact(){
        this.listContact.add(new Contact(AccountId = this.accountId));
        return null;
    }

    public Pagereference deleteContact(){

        String index = ApexPages.currentPage().getParameters().get('index');

        Contact con = this.listContact.remove(Integer.valueOf(index));

        if (con.Id != null) {
            delete con;
        }

        return null;
    }

    public PageReference editContact(){
        this.isEditMode = true;
        return null;
    }

    public PageReference saveContact(){

        upsert this.listContact;
        this.isEditMode = false;

        return null;
    }
}