package model;

public class CheckList {

	private int pNum;
	private int tNum;
	private int iNum;
	private int clNum;
	private String clName;
	
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
	public String getClName() {
		return clName;
	}
	public void setClName(String clName) {
		this.clName = clName;
	}
	@Override
	public String toString() {
		return "CheckList [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", clNum=" + clNum + ", clName="
				+ clName + "]";
	}
	
}
