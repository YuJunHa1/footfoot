package footfoot.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
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

//@WebServlet("/ControllerServlet")
@WebServlet(urlPatterns = "*.do", initParams = {@WebInitParam(name = "initParam", value = "/WEB-INF/commandHandler.properties")})
public class ControllerServlet extends HttpServlet {
	// Controller 기능을 구현 = 비즈니스 로직 처리
	private static final long serialVersionUID = 1L;
	
	// <커맨드, 핸들러인스턴스> 매핑 정보 저장
	private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();
	
	// 서블릿을 생성하고 초기화 할 때 제일 먼저 자동으로 호출되는 init() 메소드 이용
	public void init(ServletConfig config) throws ServletException {
		String configFile = config.getInitParameter("initParam");
		String configFilePath = config.getServletContext().getRealPath(configFile);
		
		Properties prop = new Properties();
		
		try (FileInputStream fis = new FileInputStream(configFilePath)) {
			prop.load(fis);
		} catch (Exception e) {
			throw new ServletException(e);
		}
		
		//속성 파일을 하나씩 읽어서 키(요청패턴)와 실행명령 핸들러 객체명 맵에 저장
		Iterator<Object> keyIter = prop.keySet().iterator();
		
		while(keyIter.hasNext()) {
			// command = hello.do
			String command = (String)keyIter.next();
			
			// handlerClassName => "week11.HelloHandler" 문자열
			String handlerClassName = prop.getProperty(command);
			
			// 클래스 문자열로 실제 객체 인스턴스 생성
			try {
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
				
				commandHandlerMap.put(command, handlerInstance);
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
       
    public ControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			process(request, response);
		} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			process(request, response);
		} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 요청이 들어오면 실행되는 메소드
		//String command = request.getParameter("command");
		
		// getRequestURI() : /week11/hello.do
		String command = request.getRequestURI();
		
		// getContextPath() : /week11
		command = command.substring(request.getContextPath().length()+1);
		// 위 명령문을 실행한 결과 command = hello.do 저장
		
		CommandHandler handler = commandHandlerMap.get(command);
		
		// 다음 뷰 페이지를 저장
		// 인터페이스의 다형성
		String viewPage = handler.process(request, response);
		
		// 다음 페이지로 넘기는 방법
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/"+viewPage+".jsp");
		rd.forward(request, response);
	}

}

