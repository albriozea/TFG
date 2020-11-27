
package forms;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

public class RegisterUserForm {

	// Constructors -----------------------------------------------------------

	public RegisterUserForm() {
		super();
	}

	// Properties -------------------------------------------------------------


	private String	name;
	private String	surnames;
	private String	email;
	private String	username;
	private String	password;
	private String	confirmPassword;


	@NotBlank

	public String getName() {
		return this.name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	@NotBlank

	public String getSurnames() {
		return this.surnames;
	}
	public void setSurnames(final String surnames) {
		this.surnames = surnames;
	}

	@NotBlank
	@Pattern(regexp = "^[\\w]+@(?:[a-zA-Z0-9]+\\.)+[a-zA-Z0-9]+|(([\\w]\\s)*[\\w])+<\\w+@(?:[a-zA-Z0-9]+\\.)+[a-zA-Z0-9]+>$")
	public String getEmail() {
		return this.email;
	}

	public void setEmail(final String email) {
		this.email = email;
	}

	@Size(min = 5, max = 32)

	public String getUsername() {
		return this.username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}

	@Size(min = 5, max = 32)

	public String getPassword() {
		return this.password;
	}

	public void setPassword(final String password) {
		this.password = password;
	}

	@Size(min = 5, max = 32)

	public String getConfirmPassword() {
		return this.confirmPassword;
	}

	public void setConfirmPassword(final String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	//Business metohds--------------------------------------------
	public Boolean checkPassword() {
		Boolean res;

		if (this.getPassword().equals(this.getConfirmPassword()))
			res = true;
		else
			res = false;

		return res;
	}
}
