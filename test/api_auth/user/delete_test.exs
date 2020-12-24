defmodule ApiAuth.User.DeleteTest do
  use ApiAuth.DataCase

  alias ApiAuth.User.{Delete, Create}

  describe "call/1" do
    setup do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}
      {:ok, user} = Create.call(params)

      {:ok, user: user}
    end

    test "when id is valid, delete the user", user do

      {:ok, response} = Delete.call(user[:user].id)

      assert response.id == user[:user].id
      assert response.name == user[:user].name
    end

    test "when id is format invalid, return the error" do
      response = Delete.call("1234")

      assert response == {:error, %{message: "Invalid ID format!", status: 400}}
    end

    test "when id is format valid but User is not found, return the error" do
      response = Delete.call(Ecto.UUID.generate())

      assert response == {:error, %{message: "User not found", status: 404}}
    end
  end
end
