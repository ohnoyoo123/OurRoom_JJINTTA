package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//첨부파일을 다운로드 받기위한 뷰

public class DownloadView extends AbstractView {

	private File file;

	public DownloadView(File file) {
		setContentType("application/download; charset=UTF-8");
		this.file = file;
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> arg0, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());

		String userAgent = request.getHeader("User-Agent");
		// InternetExplorer인지 확인
		boolean ie = userAgent.indexOf("MSIE") > -1;

		String filename = null;
		if (ie) {
			filename = URLEncoder.encode(file.getName(), "UTF-8");
		} else {
			filename = new String(file.getName().getBytes("UTF-8"));
		}
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = new FileInputStream(file);
		try {
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (fis != null) {
					fis.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		out.flush();
	}

}
