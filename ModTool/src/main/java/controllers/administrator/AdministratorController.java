
package controllers.administrator;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.User;
import services.UserService;

@Controller
@RequestMapping("/actor/administrator")
public class AdministratorController extends AbstractController {

	//Services

	@Autowired
	private UserService userService;

	//Methods


	@RequestMapping(value = "/profile/list", method = RequestMethod.GET)
	public ModelAndView listProfile() {

		final ModelAndView result;
		final Collection<User> users;

		users = this.userService.findAll();

		result = new ModelAndView("administrator/listActor");

		result.addObject("admin", true);
		result.addObject("actors", users);
		result.addObject("requestURI", "actor/administrator/profile/list.do");

		return result;

	}

}
