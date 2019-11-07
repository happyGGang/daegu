package kr.co.whalesoft.framework.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;

import org.apache.commons.codec.binary.Base64;

public class CalculateHashUtils {
	
	public static String calculateHash(String message) {
		MessageDigest sha256 = null;
		try {
			sha256 = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		sha1.update(message.getBytes());
//        byte[] hash = sha1.digest();
        byte[] hash = Base64.encodeBase64(sha256.digest(message.getBytes()));
        
        Formatter formatter = new Formatter();
        for (byte b : hash) {
            formatter.format("%02x", b);
        }
        String returnFormatter = formatter.toString();
        
        formatter.close();
        return returnFormatter;
    }
}
