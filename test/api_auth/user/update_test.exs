defmodule ApiAuth.User.UpdateTest do
  use ApiAuth.DataCase

  alias ApiAuth.User.{Create, Update}

  describe "call/1" do
    setup do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}
      {:ok, user} = Create.call(params)
      {:ok, user: user}
    end

    test "when id is valid, return the user", %{user: user} do
      params = %{"id" => user.id, "name" => "Joaquim", "email" => "joao@gmail.com", "password" => "987654" }
      {:ok, response} = Update.call(params)

      assert response.id == user.id
      assert response.inserted_at == user.inserted_at
    end

    test "when id is format invalid, return the error" do
      params = %{"id" => "1234", "name" => "Joaquim", "email" => "joao@gmail.com", "password" => "987654" }
      response = Update.call(params)

      assert response == {:error, %{message: "Invalid ID format!", status: 400}}
    end

    test "when id is format valid but user is not found, return the error" do
      params = %{"id" => Ecto.UUID.generate(), "name" => "Joaquim", "email" => "joao@gmail.com", "password" => "987654" }
      response = Update.call(params)

      assert response == {:error, %{message: "User not found", status: 404}}
    end
  end
end
