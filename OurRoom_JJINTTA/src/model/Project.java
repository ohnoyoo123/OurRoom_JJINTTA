package model;

import java.util.Date;

public class Project {

	private int pNum;
	private String pName;
	private String pStartDate;
	private String pEndDate;
	private String pBackground;
	
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpStartDate() {
		return pStartDate;
	}
	public void setpStartDate(String pStartDate) {
		this.pStartDate = pStartDate;
	}
	public String getpEndDate() {
		return pEndDate;
	}
	public void setpEndDate(String pEndDate) {
		this.pEndDate = pEndDate;
	}
	public String getpBackground() {
		return pBackground;
	}
	public void setpBackground(String pBackground) {
		this.pBackground = pBackground;
	}
	@Override
	public String toString() {
		return "Project [pNum=" + pNum + ", pName=" + pName + ", pStartDate=" + pStartDate + ", pEndDate=" + pEndDate
				+ ", pBackground=" + pBackground + "]";
	}
	
	
}
