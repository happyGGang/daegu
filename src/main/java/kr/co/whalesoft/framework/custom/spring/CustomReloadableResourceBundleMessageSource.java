/*
 * Copyright 2017 hbaram.
 *
 */

package kr.co.whalesoft.framework.custom.spring;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.util.PropertiesPersister;

public class CustomReloadableResourceBundleMessageSource extends ReloadableResourceBundleMessageSource {
	
	private ResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver(); 
	
	public void setPropertiesPersister(PropertiesPersister propertiesPersister) {
		super.setPropertiesPersister(propertiesPersister);
	}
		
	/**
	 * 소스폴더에서 메세지 관련 파일 찾아등록 함수
	 */
	@Override
	public void setBasenames(String... basenames) {
		
		if (basenames != null) { 
			List<String> baseNames = new ArrayList<String>(); 
			for (int i = 0; i < basenames.length; i++) {
				
				String basename = basenames[i].trim();
				
				if(basename.indexOf("*") == -1){
					baseNames.add(basename);
				}else{
				
					if (basename != null && !basename.equals("")) { 
						
						try {
							Resource[] resources = resourcePatternResolver.getResources(basename);
							
							for ( int j = 0; j < resources.length; j++ ){
								String filePath = "";
								String baseName2 = null;
								filePath = resources[ j ].getFile().getPath();
								if(filePath.indexOf("_") != -1){
									baseName2 = "classpath:"+filePath.substring( filePath.indexOf("WEB-INF") + 16, filePath.lastIndexOf("_") ).replace( '\\', '/' );
									baseNames.add(baseName2);
								}
									
									
							}
						} catch (IOException e) {
							
							System.out.println("Minsoo Message boot error! : "+basename);
							//e.printStackTrace();
						} 
						
					}
				}
			}
			String[] resourceBasenames = baseNames.toArray(new String[baseNames.size()]);
			super.setBasenames(resourceBasenames);
		}
				
		
	}
	


}

