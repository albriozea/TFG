
package controllers;

import java.util.Locale;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/welcome")
public class WelcomeController extends AbstractController {

	// Constructors -----------------------------------------------------------

	public WelcomeController() {
		super();
	}

	// Index ------------------------------------------------------------------
	@RequestMapping(value = "/index")
	public ModelAndView index() {
		ModelAndView result;

		final Locale locale = LocaleContextHolder.getLocale();
		final String language = locale.getLanguage();
		String welcomeMessage = "";

		if (language == "es")
			welcomeMessage = "Buenos días María, buenas tardes José";
		else if (language == "en")
			welcomeMessage = "Good morning Mary, good evening Joshep";

		result = new ModelAndView("welcome/index");
		result.addObject("welcomeMessage", welcomeMessage);

		return result;
	}
}
