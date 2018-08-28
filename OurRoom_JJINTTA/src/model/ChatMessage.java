package model;

import java.sql.Timestamp;

public class ChatMessage {

	private int chNum;
	private String mId;
	private String chlContent;
	private Timestamp chlWriteTime;
	
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
	public String getChlContent() {
		return chlContent;
	}
	public void setChlContent(String chlContent) {
		this.chlContent = chlContent;
	}
	public Timestamp getChlWriteTime() {
		return chlWriteTime;
	}
	public void setChlWriteTime(Timestamp chlWriteTime) {
		this.chlWriteTime = chlWriteTime;
	}
	@Override
	public String toString() {
		return "ChatMessage [chNum=" + chNum + ", mId=" + mId + ", chlContent=" + chlContent + ", chlWriteTime="
				+ chlWriteTime + "]";
	}
	
}
