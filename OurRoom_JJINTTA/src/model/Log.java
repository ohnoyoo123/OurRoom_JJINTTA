package model;

import java.sql.Timestamp;

public class Log {

	private int pNum;
	private int tNum;
	private int iNum;
	private int clNum;
	private int ciNum;
	private int cmNum;
	private String mId;
	private int lNum;
	private int lCat;
	private Timestamp lTime;
	private String lName; // [김승겸] 2018. 9. 6 (추가) pName, tName,iName,clName,ciName,cmContent 등이 담길 필드
	// lCat 상수값
	/**
	 * project create
	 */
	public static final int P_CREATE = 11; // 프로젝트 생성
	public static final int P_ADD_MEMBER = 13; // 프로젝트 멤버 추가
	public static final int P_DELETE_MEMBER = 14; // 프로젝트 멤버 삭제
	public static final int P_UPDATE_NAME = 19; // 프로젝트 이름 변경
	public static final int T_CREATE = 21; // 태스크 생성
	public static final int I_CREATE = 31; // 이슈 생성
	public static final int I_DELETE = 32; // 이슈 삭제
	public static final int I_ADD_MEMBER = 33; // 이슈 멤버 할당
	public static final int CL_CREATE = 41; // 체크리스트 생성
	public static final int CL_DELETE = 42; // 체크리스트 삭제
	public static final int CI_CREATE = 51; // 체크리스트 아이템 생성
	public static final int CI_DELETE = 52; // 체크리스트 아이템 삭제
	public static final int CI_ADD_MEMBER = 53; // 체크리스트 멤버 할당
	public static final int CM_ADD = 61; // 코멘트 등록
	public static final int CM_ADD_MEMBER = 63; // 코멘트 멤버 할당

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

	public int getCmNum() {
		return cmNum;
	}

	public void setCmNum(int cmNum) {
		this.cmNum = cmNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getlNum() {
		return lNum;
	}

	public void setlNum(int lNum) {
		this.lNum = lNum;
	}

	public int getlCat() {
		return lCat;
	}

	public void setlCat(int lCat) {
		this.lCat = lCat;
	}

	public Timestamp getlTime() {
		return lTime;
	}

	public void setlTime(Timestamp lTime) {
		this.lTime = lTime;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

	@Override
	public String toString() {
		return "Log [pNum=" + pNum + ", tNum=" + tNum + ", iNum=" + iNum + ", clNum=" + clNum + ", ciNum=" + ciNum
				+ ", cmNum=" + cmNum + ", mId=" + mId + ", lNum=" + lNum + ", lCat=" + lCat + ", lTime=" + lTime
				+ ", lName=" + lName + "]";
	}


}
