package model;

public class LogMember {

	private int pNum;
	private String mId;
	private int lNum;
	
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public int getlNum() {
		return lNum;
	}
	public void setlNum(int lNum) {
		this.lNum = lNum;
	}
	@Override
	public String toString() {
		return "LogMember [pNum=" + pNum + ", mId=" + mId + ", lNum=" + lNum + "]";
	}
	
}
