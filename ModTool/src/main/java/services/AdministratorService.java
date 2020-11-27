
package services;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import domain.Actor;
import domain.Administrator;
import repositories.AdministratorRepository;
import security.Authority;
import security.UserAccount;

@Service
@Transactional
public class AdministratorService {

	// Managed Repository ------------------------
	@Autowired
	private AdministratorRepository	administratorRepository;

	// Suporting services ------------------------

	@Autowired
	private ActorService			actorService;

	@Autowired
	private Validator				validator;

	// Simple CRUD methods -----------------------


	public Collection<Administrator> findAll() {

		Collection<Administrator> result;
		result = this.administratorRepository.findAll();
		Assert.notNull(result);
		return result;
	}

	public Administrator findOne(final int administratorId) {

		Assert.notNull(administratorId);
		Administrator result;
		result = this.administratorRepository.findOne(administratorId);
		return result;
	}

	public Administrator save(final Administrator administrator) {

		Assert.notNull(administrator);
		Administrator result;

		if (administrator.getId() != 0) {
			final Authority admin = new Authority();
			admin.setAuthority(Authority.ADMIN);

			final Actor actor = this.actorService.findByPrincipal();
			Assert.notNull(actor);

			Assert.isTrue(actor.getId() == administrator.getId());

			result = this.administratorRepository.save(administrator);

		} else {

			String pass = administrator.getUserAccount().getPassword();

			final Md5PasswordEncoder code = new Md5PasswordEncoder();

			pass = code.encodePassword(pass, null);

			final UserAccount userAccount = administrator.getUserAccount();
			userAccount.setPassword(pass);

			administrator.setUserAccount(userAccount);

			result = this.administratorRepository.save(administrator);

		}
		return result;
	}

	public Administrator reconstruct(final Administrator admin, final BindingResult binding) {

		final Administrator result;

		final Administrator adminBBDD = this.findOne(admin.getId());

		if (adminBBDD != null) {

			admin.setUserAccount(adminBBDD.getUserAccount());

			this.validator.validate(admin, binding);

		}
		result = admin;

		return result;

	}

	public void flush() {
		this.administratorRepository.flush();
	}

}
