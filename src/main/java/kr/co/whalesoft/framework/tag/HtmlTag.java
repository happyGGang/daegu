package kr.co.whalesoft.framework.tag;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HtmlTag {

	private String name;
	private String content;
	private boolean emptyContent = true;
	private Map<String, String> attributes = new HashMap<String, String>();
	private List<HtmlTag> subTags = new ArrayList<HtmlTag>();
	private int subTagPrintType = 1;
	
	public HtmlTag(String name) {
		this.name = name;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	public void setEmptyContent( boolean emptyContent ) {
		this.emptyContent = emptyContent;
	}
	
	public void setAttribute( String name, String value ) {
		attributes.put( name, value );
	}
	
	public String getAttribute(String name){
		return attributes.get(name);
	}
	
	public void setAttribute( String value ) {
		attributes.put( "", value );
	}
	
	public void addSubTag(HtmlTag htmlTag){
		subTags.add(htmlTag);
		if ( htmlTag != null ) setEmptyContent( false );
	}
	
	// 1:감싸서 출력,2:별도로 출력,3:별도로 감싸서 출력
	public void setSubTagPrintType(int subTagPrintType) {
		this.subTagPrintType = subTagPrintType;
	}

	@Override
	public String toString() {
		
		StringBuilder sb = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();	//하위테그용
		
		sb.append( "<" + name );
		
		for ( Map.Entry<String, String> entry : attributes.entrySet() ) {
			if ( entry.getKey() == null || entry.getValue() == null ) continue;
			if ( entry.getKey().equals("")){
				sb.append( " " + entry.getValue() );
				sb2.append( " " + entry.getValue() );
			} else {
				sb.append( " " + entry.getKey() );
				sb.append( "=\"" );
				sb.append( entry.getValue() );
				sb.append( "\"" );
				
				if(entry.getKey().equals("class") || entry.getKey().equals("id")){
					sb2.append( " " + entry.getKey() );
					sb2.append( "=\"" );
					sb2.append( entry.getValue()+"s" );
					sb2.append( "\"" );
				}
			}
		}
		
		sb.append( ">" );
		String tail = "</" + name + ">";
		if ( content != null ) sb.append( content );
		switch(subTagPrintType){
		case 1 :
			if(subTags.size() > 0) sb.append(subTagToString());
			sb.append( tail );
			break;
		case 2 :
			sb.append( tail );
			if(subTags.size() > 0) sb.append(subTagToString());
			break;
		case 3 :
			sb.append( tail );
			if(subTags.size() > 0){
				sb.append( "<" + name + sb2.toString() + ">" );
				sb.append(subTagToString());
				sb.append( tail );
			}
			break;
			
		}
		
		return sb.toString();
	}

	private String subTagToString() {
		StringBuilder sb = new StringBuilder();
		for(HtmlTag htmlTag : subTags) {
			sb.append("\n" + htmlTag.toString());
		}
		return sb.toString();
	}

	public boolean isEmptyContent() {
		return emptyContent;
	}
}