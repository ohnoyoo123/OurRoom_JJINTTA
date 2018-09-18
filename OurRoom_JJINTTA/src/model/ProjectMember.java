package model;

public class ProjectMember {

	private int pNum;
	private String mId;
	private Boolean pmIsAdmin;
	private Boolean pmIsAuth;
	private Boolean pmFav;
	private String mNickname;
	
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public Boolean getPmIsAdmin() {
		return pmIsAdmin;
	}
	public void setPmIsAdmin(Boolean pmIsAdmin) {
		this.pmIsAdmin = pmIsAdmin;
	}
	public Boolean getPmIsAuth() {
		return pmIsAuth;
	}
	public void setPmIsAuth(Boolean pmIsAuth) {
		this.pmIsAuth = pmIsAuth;
	}
	public Boolean getPmFav() {
		return pmFav;
	}
	public void setPmFav(Boolean pmFav) {
		this.pmFav = pmFav;
	}
	public String getmNickname() {
		return mNickname;
	}
	public void setmNickname(String mNickname) {
		this.mNickname = mNickname;
	}
	@Override
	public String toString() {
		return "ProjectMember [pNum=" + pNum + ", mId=" + mId + ", pmIsAdmin=" + pmIsAdmin + ", pmIsAuth=" + pmIsAuth
				+ ", pmFav=" + pmFav + ", mNickname=" + mNickname + "]";
	}
	
	
}
