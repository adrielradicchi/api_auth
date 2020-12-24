defmodule ApiAuth.User.GetTest do
  use ApiAuth.DataCase

  alias ApiAuth.{User.Create, User.Get}

  describe "call/1" do
    setup do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}
      {:ok, user} = Create.call(params)
      {:ok, user: user}
    end

    test "when id is valid, return the user", %{user: user} do
      {:ok, response} = Get.call(user.id)

      assert response.id == user.id
      assert response.name == user.name
    end

    test "when id is format invalid, return the error" do
      response = Get.call("1234")

      assert response == {:error, %{message: "Invalid ID format!", status: 400}}
    end

    test "when id is format valid but User is not found, return the error" do
      response = Get.call(Ecto.UUID.generate())

      assert response == {:error, %{message: "User not found", status: 404}}
    end
  end
end
