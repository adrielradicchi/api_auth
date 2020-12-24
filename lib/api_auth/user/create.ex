defmodule ApiAuth.User.Create do

  alias ApiAuth.{Repo,User}

  def call(params) do
    params
    |> User.build()
    |> create_user()
    |> validate_insert()
  end

  defp create_user({:ok, struct}), do: Repo.insert(struct)
  defp create_user({:error, _changeset} = error), do: error

  defp validate_insert({:ok, _user} = user), do: user
  defp validate_insert({:error, _changeset} = error), do: error
end
