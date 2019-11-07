package kr.co.whalesoft.framework.custom.spring;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.springframework.util.DefaultPropertiesPersister;
import org.springframework.util.StringUtils;

public class CustomPropertiesPersister extends DefaultPropertiesPersister{
	
	

	@Override
	public void load(Properties props, Reader reader) throws IOException {
		/*if (super.loadFromReaderAvailable) {
			// On JDK 1.6+
			props.load(reader);
		}
		else {
			// Fall back to manual parsing.
*/			doLoad(props, reader);
		//}
	}
	
	@Override
	protected void doLoad(Properties props, Reader reader) throws IOException {
		BufferedReader in = new BufferedReader(reader);
		String classPackageName = "";
		while (true) {
			String line = in.readLine();
			if (line == null) {
				return;
			}
			line = StringUtils.trimLeadingWhitespace(line);
			if (line.length() > 0) {
				char firstChar = line.charAt(0);
				
				//package명을 입력해둬야한다 @kr.co.whalesoft
				if(firstChar == '@') classPackageName = line.substring(1, line.length())+".";
				
				if (firstChar != '#' && firstChar != '!' && firstChar != '@') {
					while (endsWithContinuationMarker(line)) {
						String nextLine = in.readLine();
						line = line.substring(0, line.length() - 1);
						if (nextLine != null) {
							line += StringUtils.trimLeadingWhitespace(nextLine);
						}
					}
					
					int separatorIndex = line.indexOf("=");
					if (separatorIndex == -1) {
						separatorIndex = line.indexOf(":");
					}
					String key = classPackageName+(separatorIndex != -1 ? line.substring(0, separatorIndex) : line);
					String value = (separatorIndex != -1) ? line.substring(separatorIndex + 1) : "";
					key = StringUtils.trimTrailingWhitespace(key);
					value = StringUtils.trimLeadingWhitespace(value);
					props.put(unescape(key), unescape(value));
				}
			}
		}
	}

}
