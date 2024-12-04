package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.time.format.DateTimeFormatter;
import footfoot.DAO.PostDAO;
import footfoot.model.Post;

public class PostHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String post_type = "free";
        int pageNumber = 1;

        // 페이지 번호 가져오기
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }

        // 게시글 목록 가져오기
        PostDAO postDAO = new PostDAO();
        ArrayList<Post> list = postDAO.getList(pageNumber, post_type);

        // 날짜 포맷팅 (yyyy-MM-dd)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (Post post : list) {
            if (post.getCreated_at() != null) {
                post.setFormattedDate(post.getCreated_at().format(formatter));
            }
        }

        // 페이징 처리
        boolean hasNextPage = postDAO.nextPage(pageNumber + 1);

        // Request 속성에 데이터 설정
        request.setAttribute("postList", list);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("hasNextPage", hasNextPage);

        return "post"; // post.jsp로 포워딩
    }
}