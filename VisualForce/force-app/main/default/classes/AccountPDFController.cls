public class AccountPDFController {

    Id accountId;

    public AccountPDFController() {
        this.accountId = ApexPages.currentPage().getParameters().get('Id');
    }

    public Account getCurrentAccount(){
        return [SELECT Name, WebSite, Phone FROM Account WHERE id =: this.accountId];
    }

    public List<String> getContactsInformation(){
        List<String> contactsInformation = new List<String>();
        String infoTemplate = 'Name: {0} {1} | Email: {2}';
        for(Contact con :[SELECT FirstName, LastName, Email FROM Contact WHERE accountId =: this.accountId] ){
            contactsInformation.add(String.format(infoTemplate, new List<Object>{con.FirstName, con.LastName, con.Email}));
        }

        return contactsInformation;
    }
}