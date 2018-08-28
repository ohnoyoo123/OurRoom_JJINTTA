package model;

import java.util.Date;

public class Issue {

	private int pNum;
	private int tNum;
	private int iNum;
	private int iStep;
	private int iOrder;
	private String iName;
	private String iDscr;
	private Date iStartDate;
	private Date iEndDate;
	private int iImpr;
	
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
	public int getiStep() {
		return iStep;
	}
	public void setiStep(int iStep) {
		this.iStep = iStep;
	}
	public int getiOrder() {
		return iOrder;
	}
	public void setiOrder(int iOrder) {
		this.iOrder = iOrder;
	}
	public String getiName() {
		return iName;
	}
	public void setiName(String iName) {
		this.iName = iName;
	}
	public String getiDscr() {
		return iDscr;
	}
	public void setiDscr(String iDscr) {
		this.iDscr = iDscr;
	}
	public Date getiStartDate() {
		return iStartDate;
	}
	public void setiStartDate(Date iStartDate) {
		this.iStartDate = iStartDate;
	}
	public Date getiEndDate() {
		return iEndDate;
	}
	public void setiEndDate(Date iEndDate) {
		this.iEndDate = iEndDate;
	}
	public int getiImpr() {
		return iImpr;
	}
	public void setiImpr(int iImpr) {
		this.iImpr = iImpr;
	}
	@Override
	public String toString() {
		return "Issue [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", iStep=" + iStep + ", iOrder=" + iOrder
				+ ", iName=" + iName + ", iDscr=" + iDscr + ", iStartDate=" + iStartDate + ", iEndDate=" + iEndDate
				+ ", iImpr=" + iImpr + "]";
	}
	
	
}
