defmodule VulnerableApi.Guardian do
  use Guardian, otp_app: :vulnerable_api
  alias VulnerableApi.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id} = _claims) do
    Accounts.get_user(id)
  end
end
