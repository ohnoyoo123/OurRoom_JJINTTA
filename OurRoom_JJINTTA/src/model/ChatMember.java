package model;

import java.sql.Timestamp;

public class ChatMember {

	private int chNum;
	private String mId;
	private Timestamp chReadTime;
	private Timestamp chInvitedTime;
	
	public int getChNum() {
		return chNum;
	}
	public void setChNum(int chNum) {
		this.chNum = chNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public Timestamp getChReadTime() {
		return chReadTime;
	}
	public void setChReadTime(Timestamp chReadTime) {
		this.chReadTime = chReadTime;
	}
	public Timestamp getChInvitedTime() {
		return chInvitedTime;
	}
	public void setChInvitedTime(Timestamp chInvitedTime) {
		this.chInvitedTime = chInvitedTime;
	}
	@Override
	public String toString() {
		return "ChatMember [chNum=" + chNum + ", mId=" + mId + ", chReadTime=" + chReadTime + ", chInvitedTime="
				+ chInvitedTime + "]";
	}
	
	
	
}
