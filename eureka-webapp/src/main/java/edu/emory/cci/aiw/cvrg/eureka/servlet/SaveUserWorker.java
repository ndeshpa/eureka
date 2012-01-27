package edu.emory.cci.aiw.cvrg.eureka.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.MediaType;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import edu.emory.cci.aiw.cvrg.eureka.common.entity.Role;
import edu.emory.cci.aiw.cvrg.eureka.common.entity.User;

public class SaveUserWorker implements ServletWorker {

	public void execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		Client c = Client.create();
		System.out.println("id = " + id);
		// TODO: change hardcoding to init param in web.xml
		WebResource webResource = c.resource("http://localhost:8181/eureka-services");
		User user = webResource.path("/api/user/"+id)
				.accept(MediaType.APPLICATION_JSON)
				.get(User.class);
		String [] roles = req.getParameterValues("role");
		List<Role> userRoles = new ArrayList<Role>();
		for (String roleId : roles) {
			Role role = webResource.path("/api/role/"+roleId)
					.accept(MediaType.APPLICATION_JSON)
					.get(Role.class);
			userRoles.add(role);
			System.out.println("role = " + roleId);
		}
		user.setRoles(userRoles);
		webResource = c.resource("http://localhost:8181/eureka-services");
		ClientResponse response = webResource.path("/api/user/put")
				.type(MediaType.APPLICATION_JSON)
				.post(ClientResponse.class, user);
		System.out.println("response = " + response.getStatus());

		resp.sendRedirect(req.getContextPath() + "/protected/user?action=list");
	}
}
