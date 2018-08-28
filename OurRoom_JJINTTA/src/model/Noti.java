package model;

public class Noti {

	private int pNum;
	private int lNum;
	private String mId;
	private Boolean nIsRead;
	
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public int getlNum() {
		return lNum;
	}
	public void setlNum(int lNum) {
		this.lNum = lNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public Boolean getnIsRead() {
		return nIsRead;
	}
	public void setnIsRead(Boolean nIsRead) {
		this.nIsRead = nIsRead;
	}
	@Override
	public String toString() {
		return "Noti [pNum=" + pNum + ", lNum=" + lNum + ", mId=" + mId + ", nIsRead=" + nIsRead + "]";
	}
	
	
}
