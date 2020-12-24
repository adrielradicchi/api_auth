defmodule ApiAuth.User.CreateTest do
  use ApiAuth.DataCase

  alias ApiAuth.{User, Repo}
  alias User.Create

  describe "call/1" do
    test "when all params are valid, creates a user" do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      count_before = Repo.aggregate(User, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(User, :count)

      assert {:ok, %User{name: "Adriel", email: "joao@gmail.com"}} = response
      assert count_after > count_before
    end

    test "when all params are invalid, return the error" do
      params = %{name: "Adriel", email: "joao@gmail.com"}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
