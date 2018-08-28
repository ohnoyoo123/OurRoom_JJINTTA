package model;

import java.sql.Timestamp;

public class Log {

	private int pNum;
	private int tNum;
	private int iNum;
	private int clNum;
	private int ciNum;
	private int cmNum;
	private String mId;
	private int lNum;
	private int lCat;
	private Timestamp lTime;
	
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
	public int getClNum() {
		return clNum;
	}
	public void setClNum(int clNum) {
		this.clNum = clNum;
	}
	public int getCiNum() {
		return ciNum;
	}
	public void setCiNum(int ciNum) {
		this.ciNum = ciNum;
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
	public int getlNum() {
		return lNum;
	}
	public void setlNum(int lNum) {
		this.lNum = lNum;
	}
	public int getlCat() {
		return lCat;
	}
	public void setlCat(int lCat) {
		this.lCat = lCat;
	}
	public Timestamp getlTime() {
		return lTime;
	}
	public void setlTime(Timestamp lTime) {
		this.lTime = lTime;
	}
	@Override
	public String toString() {
		return "Log [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", clNum=" + clNum + ", ciNum=" + ciNum
				+ ", cmNum=" + cmNum + ", mId=" + mId + ", lNum=" + lNum + ", lCat=" + lCat + ", lTime=" + lTime + "]";
	}
	

}
