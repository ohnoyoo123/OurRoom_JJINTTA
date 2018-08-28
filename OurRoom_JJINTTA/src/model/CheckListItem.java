package model;

public class CheckListItem {

	private int pNum;
	private int tNum;
	private int iNum;
	private int clNum;
	private int ciNum;
	private String ciName;
	private Boolean ciIsDone;
	
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
	public String getCiName() {
		return ciName;
	}
	public void setCiName(String ciName) {
		this.ciName = ciName;
	}
	public Boolean getCiIsDone() {
		return ciIsDone;
	}
	public void setCiIsDone(Boolean ciIsDone) {
		this.ciIsDone = ciIsDone;
	}
	@Override
	public String toString() {
		return "CheckListItem [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", clNum=" + clNum + ", ciNum="
				+ ciNum + ", ciName=" + ciName + ", ciIsDone=" + ciIsDone + "]";
	}
	
}
