
package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import domain.Actor;
import domain.Administrator;
import domain.User;
import security.Authority;
import security.Credentials;
import services.ActorService;
import services.AdministratorService;
import services.UserService;

@Controller
@RequestMapping("/profile")
public class ProfileController extends AbstractController {

	@Autowired
	private ActorService			actorService;

	@Autowired
	private UserService				userService;

	@Autowired
	private AdministratorService	administratorService;


	@RequestMapping(value = "/displayPrincipal", method = RequestMethod.GET)
	public ModelAndView display() {
		ModelAndView result;
		Actor actor;

		actor = this.actorService.findOne(this.actorService.findByPrincipal().getId());
		Assert.notNull(actor);

		result = new ModelAndView("actor/display");
		result.addObject("actor", actor);
		result.addObject("laguageURI", "profile/displayPrincipal.do");
		result.addObject("admin", false);

		return result;

	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit() {
		final ModelAndView result;
		final Actor actor;

		final Actor principal = this.actorService.findByPrincipal();
		actor = this.actorService.findOne(principal.getId());
		Assert.isTrue(actor.equals(principal));

		final Authority authority1 = new Authority();
		authority1.setAuthority(Authority.USER);

		final Authority authority2 = new Authority();
		authority2.setAuthority(Authority.ADMIN);

		String auth = null;
		String action = null;
		if (actor.getUserAccount().getAuthorities().contains(authority1)) {
			auth = "user";
			action = "editUser.do";
		} else if (actor.getUserAccount().getAuthorities().contains(authority2)) {
			auth = "administrator";
			action = "editAdministrator.do";
		}

		result = new ModelAndView("actor/edit");
		result.addObject("actionURI", action);
		result.addObject(auth, actor);
		result.addObject("authority", auth);
		result.addObject("laguageURI", "profile/edit.do");

		return result;
	}

	//--------------------------USER------------------------------

	@RequestMapping(value = "/editUser", method = RequestMethod.POST, params = "save")
	public ModelAndView saveUser(@ModelAttribute("user") final User user, final BindingResult binding) {
		ModelAndView result;

		final User userReconstruct = this.userService.reconstruct(user, binding);

		if (binding.hasErrors())
			result = this.createEditModelAndViewUser(userReconstruct);
		else
			try {
				this.userService.save(userReconstruct);
				final Credentials credentials = new Credentials();
				credentials.setJ_username(userReconstruct.getUserAccount().getUsername());
				credentials.setPassword(userReconstruct.getUserAccount().getPassword());
				result = new ModelAndView("redirect:/profile/displayPrincipal.do");
				result.addObject("credentials", credentials);
			} catch (final Throwable oops) {
				result = this.createEditModelAndViewUser(userReconstruct, "actor.commit.error");
			}
		return result;
	}

	protected ModelAndView createEditModelAndViewUser(final User user) {
		ModelAndView result;

		result = this.createEditModelAndViewUser(user, null);

		return result;
	}

	protected ModelAndView createEditModelAndViewUser(final User user, final String messageCode) {
		ModelAndView result;

		result = new ModelAndView("actor/edit");

		result.addObject("user", user);
		result.addObject("authority", "user");
		result.addObject("actionURI", "editUser.do");
		result.addObject("laguageURI", "profile/edit.do");
		result.addObject("messageError", messageCode);

		return result;
	}

	//--------------------------ADMINISTRATOR------------------------------

	@RequestMapping(value = "/editAdministrator", method = RequestMethod.POST, params = "save")
	public ModelAndView saveAdministrator(@ModelAttribute("administrator") final Administrator admin, final BindingResult binding) {
		ModelAndView result;

		final Administrator adminReconstruct = this.administratorService.reconstruct(admin, binding);

		if (binding.hasErrors())
			result = this.createEditModelAndViewAdmin(adminReconstruct);
		else
			try {
				this.administratorService.save(adminReconstruct);
				final Credentials credentials = new Credentials();
				credentials.setJ_username(adminReconstruct.getUserAccount().getUsername());
				credentials.setPassword(adminReconstruct.getUserAccount().getPassword());
				result = new ModelAndView("redirect:/profile/displayPrincipal.do");
				result.addObject("credentials", credentials);
			} catch (final Throwable oops) {
				result = this.createEditModelAndViewAdmin(adminReconstruct, "actor.commit.error");
			}
		return result;
	}

	protected ModelAndView createEditModelAndViewAdmin(final Administrator admin) {
		ModelAndView result;

		result = this.createEditModelAndViewAdmin(admin, null);

		return result;
	}

	protected ModelAndView createEditModelAndViewAdmin(final Administrator admin, final String messageCode) {
		ModelAndView result;

		result = new ModelAndView("actor/edit");

		result.addObject("administrator", admin);
		result.addObject("authority", "administrator");
		result.addObject("actionURI", "editAdministrator.do");
		result.addObject("laguageURI", "profile/edit.do");
		result.addObject("messageError", messageCode);

		return result;
	}

}
