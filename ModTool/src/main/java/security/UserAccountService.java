
package security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import domain.Actor;
import services.ActorService;

@Service
@Transactional
public class UserAccountService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private UserAccountRepository	userAccountRepository;

	// Supporting services ----------------------------------------------------

	@Autowired
	private ActorService			actorService;

	// Constructors -----------------------------------------------------------


	public UserAccountService() {
		super();
	}

	public UserAccount createUser() {

		final Authority authority = new Authority();
		authority.setAuthority(Authority.USER);
		final List<Authority> list = new ArrayList<Authority>();
		list.add(authority);

		final UserAccount userAccount = new UserAccount();
		userAccount.setAuthorities(list);

		return userAccount;

	}

	//	public UserAccount createAdmin() {
	//
	//		final Authority authority = new Authority();
	//		authority.setAuthority(Authority.ADMIN);
	//		final List<Authority> list = new ArrayList<Authority>();
	//		list.add(authority);
	//
	//		final UserAccount userAccount = new UserAccount();
	//		userAccount.setAuthorities(list);
	//
	//		return userAccount;
	//
	//	}

	public Collection<UserAccount> findAll() {

		Collection<UserAccount> result;
		result = this.userAccountRepository.findAll();
		Assert.notNull(result);
		return result;

	}

	public UserAccount findOne(final int userAccountId) {
		final Actor actor = this.actorService.findByPrincipal();
		Assert.notNull(actor);

		Assert.notNull(userAccountId);
		UserAccount result;
		result = this.userAccountRepository.findOne(userAccountId);

		return result;
	}

	public UserAccount save(final UserAccount userAccount) {

		Assert.notNull(userAccount);
		UserAccount result;

		if (userAccount.getId() != 0) {
			final Authority admin = new Authority();
			admin.setAuthority(Authority.ADMIN);

			final Actor actor = this.actorService.findByPrincipal();
			Assert.notNull(actor);

			Assert.isTrue(actor.getId() == userAccount.getId() || actor.getUserAccount().getAuthorities().contains(admin));

			result = this.userAccountRepository.save(userAccount);

		} else
			result = this.userAccountRepository.save(userAccount);

		return result;

	}

	// Other business methods -------------------------------------------------

}
