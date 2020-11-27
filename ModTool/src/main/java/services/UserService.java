
package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import domain.Actor;
import domain.User;
import forms.RegisterUserForm;
import repositories.UserRepository;
import security.Authority;
import security.UserAccount;
import security.UserAccountService;

@Service
@Transactional
public class UserService {

	// Managed repository
	@Autowired
	private UserRepository		userRepository;

	// Suporting services
	@Autowired
	private ActorService		actorService;

	@Autowired
	private UserAccountService	userAccountService;

	@Autowired
	private Validator			validator;

	// Simple CRUD methods


	public User create() {

		User result;
		result = new User();

		final UserAccount userAccount = this.userAccountService.createUser();
		result.setUserAccount(userAccount);

		return result;

	}

	public Collection<User> findAll() {

		Collection<User> result;
		result = this.userRepository.findAll();
		Assert.notNull(result);
		return result;
	}

	public User findOne(final int userId) {

		Assert.notNull(userId);
		User result;
		result = this.userRepository.findOne(userId);
		return result;
	}

	public User save(final User user) {
		Assert.notNull(user);
		User result;

		if (user.getId() != 0) {
			final Authority admin = new Authority();
			admin.setAuthority(Authority.ADMIN);

			final Actor actor = this.actorService.findByPrincipal();
			Assert.notNull(actor);

			result = this.userRepository.save(user);

		} else {

			String pass = user.getUserAccount().getPassword();

			final Md5PasswordEncoder code = new Md5PasswordEncoder();

			pass = code.encodePassword(pass, null);

			final UserAccount userAccount = user.getUserAccount();
			userAccount.setPassword(pass);

			user.setUserAccount(userAccount);

			result = this.userRepository.save(user);

		}
		return result;

	}

	//Recontruct para registrar User
	public User reconstruct(final RegisterUserForm form, final BindingResult binding) {

		this.validator.validate(form, binding);

		final User user = this.create();

		user.setName(form.getName());
		user.setSurnames(form.getSurnames());
		user.setEmail(form.getEmail());
		user.getUserAccount().setUsername(form.getUsername());
		user.getUserAccount().setPassword(form.getPassword());

		return user;

	}

	//Reconstruct para editar User

	public User reconstruct(final User user, final BindingResult binding) {

		final User result;

		final User userBBDD = this.findOne(user.getId());

		if (userBBDD != null) {

			user.setUserAccount(userBBDD.getUserAccount());

			this.validator.validate(user, binding);

		}
		result = user;
		return result;

	}

	public void flush() {
		this.userRepository.flush();
	}

}
