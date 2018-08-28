package model;

public class Address {

	private String mId;
	private String aId;
	
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getaId() {
		return aId;
	}
	public void setaId(String aId) {
		this.aId = aId;
	}
	@Override
	public String toString() {
		return "Address [mId=" + mId + ", aId=" + aId + "]";
	}
	
	
}
