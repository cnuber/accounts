# Find or create a new user with state "unclaimed"
# Given an email address:
#   attempt to find a user with that address.
#   If the user is found, return the user's id
#   Otherwise create a new user, set it's state to "unclaimed" and return that id

class FindOrCreateUnclaimedUser

  lev_routine

  uses_routine CreateUser,
               translations: { outputs: { type: :verbatim } }

  protected

  def exec(email)
    existing = ContactInfo.email_addresses.with_users.where( value: email ).first
    if existing
      outputs[:user] = existing.user
    else
      run(CreateUser, state: 'unclaimed', ensure_no_errors: true)
    end
  end

end
