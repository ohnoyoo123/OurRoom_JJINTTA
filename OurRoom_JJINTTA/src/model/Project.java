package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Project {

	private int pNum;
	private String pName;
	private Date pStartDate;
	private Date pEndDate;
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
	public Date getpStartDate() {
		return pStartDate;
	}
	public void setpStartDate(Date pStartDate) {
		this.pStartDate = pStartDate;
	}
	public Date getpEndDate() {
		return pEndDate;
	}
	public void setpEndDate(Date pEndDate) {
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
