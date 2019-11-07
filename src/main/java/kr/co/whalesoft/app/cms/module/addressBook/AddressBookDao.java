package kr.co.whalesoft.app.cms.module.addressBook;

import java.util.List;

public interface AddressBookDao {

	public List<AddressBook> getAddressTreeList(AddressBook addressBook);

	public AddressBook getAddressBookOne(AddressBook addressBook);

	public List<AddressBook> getMyItemList(AddressBook addressBook);

	public int addAddressBookGroup(AddressBook addressBook);

	public int modifyAddressBookGroup(AddressBook addressBook);

	public int getChildCount(AddressBook addressBook);

	public int deleteAddressBookGroup(AddressBook addressBook);

	public int addAddressBook(AddressBook addressBook);

	public int modifyAddressBook(AddressBook addressBook);

	public int deleteAddressBook(AddressBook addressBook);

	public int deleteAddressBookBatch(AddressBook addressBook);

}
