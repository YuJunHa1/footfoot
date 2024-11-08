package week11;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ControllerServlet
 */
@WebServlet(urlPatterns = "*.do",
			initParams = {@WebInitParam(name = "initParam",
										value = "/WEB-INF/commandHandler.properties")})
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//<커맨드, 핸들러 인스턴스> 매핑 정보 저장
	private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();
       
	//서블릿을 생성하고 초기화 할 때 제일 먼저 자동으로 호출되는 init() 메소드를 이용
	public void init(ServletConfig config) throws ServletException {
		String configFile = config.getInitParameter("initParam");
		String configFilePath = config.getServletContext().getRealPath(configFile);
		
		Properties prop = new Properties();
		
		try(FileInputStream fis = new FileInputStream(configFilePath)){
			prop.load(fis);
		} catch (Exception e) {
			throw new ServletException();
		}
		
		//속성 파일을 하나씩 읽어서 키(요청패턴)와 실행명령 핸들러객체명을 맵에 저장
		Iterator<Object> keyIter = prop.keySet().iterator();
		
		while(keyIter.hasNext()) {
			
			//command = hello.do
			String command = (String)keyIter.next();
			
			//handlerClassName => "week11.HelloHandler" 문자열
			String handlerClassName = prop.getProperty(command);
			
			//클래스 문자열로 실제 객체 인스턴스 생성
			try {
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handlerInstance = (CommandHandler)handlerClass.newInstance();
				
				//최종 결과를 맵에 저장
				commandHandlerMap.put(command,  handlerInstance);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				throw new ServletException(e);
			}
		}
	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}

	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청이 들어오면 실행되는 메소드
		
		// getRequestURI() : /week11/hello.do
		String command = request.getRequestURI();
		
		//getContextPath() : /week11
		command = command.substring(request.getContextPath().length()+1);
		//위 명령문을 실행한 결과 command = hello.do 저장
		
		CommandHandler handler = commandHandlerMap.get(command);
		
		//다음 뷰 페이지를 저장
		//인터페이스의 다형성
		String viewPage = handler.process(request, response)
		
		//다음 페이지로 넘기는 방법
		CommandHandler handler = null;
		
		if(command.equals("greeting")) {
			handler = new HelloHandler();
		}else if (command.equals("date")) {
			handler = new DateHandler();
		}else {
			handler = new NullHandler();
		}
		//다음 뷰 페이지를 저장
		String viewPage = handler.process(request, response);
		
		//다음 페이지로 넘기는 방법
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
		
	}

}
