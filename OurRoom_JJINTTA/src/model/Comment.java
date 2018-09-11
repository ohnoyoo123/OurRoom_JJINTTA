package model;

import java.sql.Timestamp;

public class Comment {

	private int pNum;
	private int tNum;
	private int iNum;
	private int cmNum;
	private String mId;
	private String cmContent;
	private String cmWriteTime;
	private int cmSuper;
	
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
	public int getCmNum() {
		return cmNum;
	}
	public void setCmNum(int cmNum) {
		this.cmNum = cmNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getCmContent() {
		return cmContent;
	}
	public void setCmContent(String cmContent) {
		this.cmContent = cmContent;
	}
	public String getCmWriteTime() {
		return cmWriteTime;
	}
	public void setCmWriteTime(String cmWriteTime) {
		this.cmWriteTime = cmWriteTime;
	}
	public int getCmSuper() {
		return cmSuper;
	}
	public void setCmSuper(int cmSuper) {
		this.cmSuper = cmSuper;
	}
	@Override
	public String toString() {
		return "Comment [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", cmNum=" + cmNum + ", mId=" + mId
				+ ", cmContent=" + cmContent + ", cmWriteTime=" + cmWriteTime + ", cmSuper=" + cmSuper + "]";
	}
	
}
