alias VulnerableApi.Accounts.User
alias VulnerableApi.Repo

params = %{
  full_name: "Admin User",
  address: "Manila",
  email: "admin@mapia.com",
  password: "P@ssw0rd123!",
  password_confirmation: "P@ssw0rd123!"
}

%User{}
|> User.changeset(params)
|> Repo.insert()
