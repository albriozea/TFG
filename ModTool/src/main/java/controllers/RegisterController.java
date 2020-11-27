
package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import domain.User;
import forms.RegisterUserForm;
import security.Credentials;
import services.UserService;

@Controller
@RequestMapping("/register")
public class RegisterController extends AbstractController {

	@Autowired
	private UserService userService;


	@RequestMapping(value = "/createUser", method = RequestMethod.GET)
	public ModelAndView createUser() {
		final ModelAndView result;
		final RegisterUserForm user = new RegisterUserForm();

		result = this.createEditModelAndViewUser(user);

		return result;
	}

	@RequestMapping(value = "/saveUser", method = RequestMethod.POST, params = "save")
	public ModelAndView saveUser(@ModelAttribute("user") final RegisterUserForm form, final BindingResult binding) {
		ModelAndView result;
		final User user;

		user = this.userService.reconstruct(form, binding);

		if (binding.hasErrors())
			result = this.createEditModelAndViewUser(form);
		else
			try {

				Assert.isTrue(form.checkPassword());
				this.userService.save(user);
				final Credentials credentials = new Credentials();
				credentials.setJ_username(user.getUserAccount().getUsername());
				credentials.setPassword(user.getUserAccount().getPassword());
				result = new ModelAndView("redirect:/security/login.do");
				result.addObject("credentials", credentials);
			} catch (final Throwable oops) {
				result = this.createEditModelAndViewUser(form, "user.commit.error");
			}
		return result;
	}
	protected ModelAndView createEditModelAndViewUser(final RegisterUserForm user) {
		ModelAndView result;

		result = this.createEditModelAndViewUser(user, null);

		return result;
	}

	protected ModelAndView createEditModelAndViewUser(final RegisterUserForm user, final String messageCode) {
		ModelAndView result;

		result = new ModelAndView("security/signUpUser");
		result.addObject("user", user);
		result.addObject("messageError", messageCode);

		return result;
	}

}
