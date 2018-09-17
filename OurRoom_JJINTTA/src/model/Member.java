package model;

public class Member {

	private String mId;
	private String mPw;
	private String mEmail;
	private String mNickname;
	private int mQuestion;
	private String mAnswer;
	private String mProfile;

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmPw() {
		return mPw;
	}

	public void setmPw(String mPw) {
		this.mPw = mPw;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public String getmNickname() {
		return mNickname;
	}

	public void setmNickname(String mNickname) {
		this.mNickname = mNickname;
	}

	public int getmQuestion() {
		return mQuestion;
	}

	public void setmQuestion(int mQuestion) {
		this.mQuestion = mQuestion;
	}

	public String getmAnswer() {
		return mAnswer;
	}

	public void setmAnswer(String mAnswer) {
		this.mAnswer = mAnswer;
	}

	public String getmProfile() {
		return mProfile;
	}

	public void setmProfile(String mProfile) {
		this.mProfile = mProfile;
	}

	@Override
	public String toString() {
		return "Member [mId=" + mId + ", mPw=" + mPw + ", mEmail=" + mEmail + ", mNickname=" + mNickname
				+ ", mQuestion=" + mQuestion + ", mAnswer=" + mAnswer + ", mProfile=" + mProfile + "]";
	}

}
