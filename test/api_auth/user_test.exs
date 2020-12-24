defmodule ApiAuth.UserTest do
  use ApiAuth.DataCase

  alias ApiAuth.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{changes: %{name: "Adriel", email: "joao@gmail.com", password: "123456"}, errors: [], data: %ApiAuth.User{}, valid?: true} = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{email: "joao@gmail.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{changes: %{password: "123456"}, data: %ApiAuth.User{}, valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a User struct" do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      response = User.build(params)

      assert {:ok, %User{name: "Adriel", email: "joao@gmail.com", password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{ email: "joao@gmail.com", password: "123456"}

      {:error, response} = User.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
