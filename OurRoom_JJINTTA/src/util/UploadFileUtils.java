package util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	private static final String uploadPath = "C:/java/profile/";

	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

	public static byte[] getProfileUtilToByteArray(String profileName) throws IOException, NoSuchAlgorithmException {

		// String profileName = ((Member)
		// session.getAttribute("loginUser")).getmProfile();
		System.out.println(profileName);
		File profile = new File(uploadPath + profileName);

		if (profileName == null || profileName.equals("")) {
			profile = new File(uploadPath + "default_profile.PNG");
		} else {
			if (profile.exists()) {

			} else {
				profile = new File(uploadPath + "default_profile.PNG");
			}

		}

		FileInputStream fis = new FileInputStream(profile);

		byte[] byteArr = IOUtils.toByteArray(fis);
		if (fis != null) {
			fis.close();
		}
		// Base64로 인코딩
		byte[] encoded = Base64.encodeBase64(byteArr);
		return encoded;

	}

	public static String getProfileUtilToString(String profileName) throws IOException, NoSuchAlgorithmException {

		// String profileName = ((Member)
		// session.getAttribute("loginUser")).getmProfile();
		File profile = new File(uploadPath + profileName);

		if (profileName == null || profileName.equals("")) {
			profile = new File(uploadPath + "s_default_profile.PNG");
		} else {
			System.out.println("getProfile : " + profile);
			if (profile.exists()) {

			} else {
				profile = new File(uploadPath + "s_default_profile.PNG");
			}

		}

		FileInputStream fis = new FileInputStream(profile);

		byte[] byteArr = IOUtils.toByteArray(fis);
		if (fis != null) {
			fis.close();
		}
		// Base64로 인코딩
		String encoded = Base64.encodeBase64String(byteArr);
		return encoded;
	}

	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {

		// UUID uid = UUID.randomUUID();

		// String savedName = uid.toString() + "_" + originalName;
		String savedName = originalName;

		// String savedPath = calcPath(uploadPath);
		String savedPath = uploadPath;

		// File target = new File(uploadPath + savedPath, savedName);
		File target = new File(uploadPath, savedName);

		FileCopyUtils.copy(fileData, target);

		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		System.out.println("formatName : " + formatName);
		String uploadedFileName = null;

		if (MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}

		return uploadedFileName;

	}

	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {

		// String iconName = uploadPath + path + File.separator + fileName;
		String iconName = uploadPath + File.separator + fileName;

		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {

		// BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path,
		// fileName));
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, fileName));

		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,30);

		// String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		String thumbnailName = uploadPath + File.separator + "s_" + fileName;

		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String calcPath(String uploadPath) {

		Calendar cal = Calendar.getInstance();

		String yearPath = File.separator + cal.get(Calendar.YEAR);

		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);

		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		makeDir(uploadPath, yearPath, monthPath, datePath);

		logger.info(datePath);

		return datePath;
	}

	private static void makeDir(String uploadPath, String... paths) {

		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}

		for (String path : paths) {

			File dirPath = new File(uploadPath + path);

			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}

}