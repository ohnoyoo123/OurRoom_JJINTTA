package model;

public class ProjectMember {

	private int pNum;
	private int tNum;
	private int iNum;
	private String mId;
	
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public int gettNum() {
		return tNum;
	}
	public void settNum(int tNum) {
		this.tNum = tNum;
	}
	public int getiNum() {
		return iNum;
	}
	public void setiNum(int iNum) {
		this.iNum = iNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	@Override
	public String toString() {
		return "ProjectMember [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", mId=" + mId + "]";
	}
	
	
}
