package kr.co.whalesoft.framework.utils;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class AES128 {
	
	protected static final byte[] KEY = hexToBytes("A02028D78B4A6BF33A0C9478C70EAB29");
	protected static final byte[] IV = hexToBytes("D0FF29189BBB9ED1508DFFA74F42A60B");
	
    public static String encrypt(byte[] key, byte[] initVector, String value) {
    	try {
    		IvParameterSpec iv = new IvParameterSpec(initVector);
    		SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
    		
    		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    		cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
    		
    		byte[] encrypted = cipher.doFinal(value.getBytes());
    		
    		return Base64.encodeBase64String(encrypted);
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	
    	return null;
    }
    
    public static String decrypt(byte[] key, byte[] initVector, String encrypted) {
    	try {
    		IvParameterSpec iv = new IvParameterSpec(initVector);
    		SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
    		
    		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    		cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
    		
    		byte[] original = cipher.doFinal(Base64.decodeBase64(encrypted));
    		
    		return new String(original);
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	
    	return null;
    }
    
    public static String encrypt(String key, String initVector, String value) {
        try {
        	return encrypt(key.getBytes("UTF-8"), initVector.getBytes("UTF-8"), value);
        } catch (Exception ex) {
//            ex.printStackTrace();
        }

        return null;
    }

    public static String decrypt(String key, String initVector, String encrypted) {
    	try {
    		return decrypt(key.getBytes("UTF-8"), initVector.getBytes("UTF-8"), encrypted);
        } catch (Exception ex) {
//            ex.printStackTrace();
        }

        return null;
    }

    public static String encrypt(String value) {
    	try {
    		return encrypt(KEY, IV, value);
    	} catch(Exception e) {
//    		e.printStackTrace();
    	}
    	
    	return null;
    }
    
    public static String decrypt(String encrypted) {
    	try {
    		return decrypt(KEY, IV, encrypted);
    	} catch(Exception e) {
//    		e.printStackTrace();
    	}
    	
    	return null;
    }

	protected static byte[] hexToBytes(String s)
	{
	    int len = s.length();
	    byte[] data = new byte[len / 2];

	    for (int i = 0; i < len; i += 2)
	        data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));

	    return data;
	}

	final protected static char[] hexArray = "0123456789abcdef".toCharArray();

	protected static String bytesToHex(byte[] bytes)
	{
	    char[] hexChars = new char[bytes.length * 2];
	    for (int j = 0; j < bytes.length; j++)
	    {
	        int v = bytes[j] & 0xFF;
	        hexChars[j * 2] = hexArray[v >>> 4];
	        hexChars[j * 2 + 1] = hexArray[v & 0x0F];
	    }
	    return new String(hexChars);
	}
	
}
