package kr.go.gbelib.app.common.api;

public class ApiResponse { 
	private boolean status;
	private String message;
	private String data;
	
	public ApiResponse() {}
	
	public ApiResponse(boolean status) {
		this.status = status;
	}
	
	public ApiResponse(boolean status, String message) {
		this.setStatus(status);
		this.message = message;
	}

	public ApiResponse(String data) {
		this.data = data;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "ApiResponse [status=" + status + ", message=" + message + "]";
	}
}
