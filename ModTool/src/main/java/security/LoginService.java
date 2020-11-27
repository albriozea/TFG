
package security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

@Service
@Transactional
public class LoginService implements UserDetailsService {

	// Managed repository -----------------------------------------------------

	@Autowired
	UserAccountRepository userRepository;

	// Business methods -------------------------------------------------------


	@Override
	public UserDetails loadUserByUsername(final String username) throws UsernameNotFoundException {
		Assert.notNull(username);

		UserDetails result;

		result = this.userRepository.findByUsername(username);
		Assert.notNull(result);
		// WARNING: The following sentences prevent lazy initialisation problems!
		Assert.notNull(result.getAuthorities());
		result.getAuthorities().size();

		return result;
	}

	public static UserAccount getPrincipal() {
		UserAccount result;
		SecurityContext context;
		Authentication authentication;
		Object principal;

		context = SecurityContextHolder.getContext();
		Assert.notNull(context);
		authentication = context.getAuthentication();
		Assert.notNull(authentication);
		principal = authentication.getPrincipal();
		Assert.isTrue(principal instanceof UserAccount);
		result = (UserAccount) principal;
		Assert.notNull(result);
		Assert.isTrue(result.getId() != 0);

		return result;
	}

}
