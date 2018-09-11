package model;

import java.sql.Timestamp;
import java.util.Date;

public class Task {

	private int pNum;
	private int tNum;
	private int tOrder;
	private String tName;
	private String tDscr;
	private String tStartDate;
	private String tEndDate;
	private String tNotiName;
	private String tNotiContent;
	private Timestamp tNotiWriteTime;
	
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
	public int gettOrder() {
		return tOrder;
	}
	public void settOrder(int tOrder) {
		this.tOrder = tOrder;
	}
	public String gettName() {
		return tName;
	}
	public void settName(String tName) {
		this.tName = tName;
	}
	public String gettDscr() {
		return tDscr;
	}
	public void settDscr(String tDscr) {
		this.tDscr = tDscr;
	}
	public String gettStartDate() {
		return tStartDate;
	}
	public void settStartDate(String tStartDate) {
		this.tStartDate = tStartDate;
	}
	public String gettEndDate() {
		return tEndDate;
	}
	public void settEndDate(String tEndDate) {
		this.tEndDate = tEndDate;
	}
	public String gettNotiName() {
		return tNotiName;
	}
	public void settNotiName(String tNotiName) {
		this.tNotiName = tNotiName;
	}
	public String gettNotiContent() {
		return tNotiContent;
	}
	public void settNotiContent(String tNotiContent) {
		this.tNotiContent = tNotiContent;
	}
	public Timestamp gettNotiWriteTime() {
		return tNotiWriteTime;
	}
	public void settNotiWriteTime(Timestamp tNotiWriteTime) {
		this.tNotiWriteTime = tNotiWriteTime;
	}
	@Override
	public String toString() {
		return "Task [pNum=" + pNum + ", tNum=" + tNum + ", tOrder=" + tOrder + ", tName=" + tName + ", tDscr=" + tDscr
				+ ", tStartDate=" + tStartDate + ", tEndDate=" + tEndDate + ", tNotiName=" + tNotiName
				+ ", tNotiContent=" + tNotiContent + ", tNotiWriteTime=" + tNotiWriteTime + "]";
	}
	
	
}
