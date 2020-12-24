defmodule ApiAuthWeb.UsersControllerTest do
  use ApiAuthWeb.ConnCase

  alias ApiAuth.User

  describe "create/2" do
    test "when create a user valid, return the user", %{conn: conn} do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "User created!", "user" => %{"id" => _id, "inserted_at" => _inserted_at, "name" => "Adriel", "email" => "joao@gmail.com"}} = response

    end

    test "when there is an error, return the error", %{conn: conn} do
      params = %{name: "Adriel", email: "joao@gmail.com" }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"password" => ["can't be blank"]}}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when there is a User with given id, return the user", %{conn: conn} do
      params = %{name: "Adriel", password: "123456", email: "joao@gmail.com" }

      {:ok, %User{id: id}} = ApiAuth.create_user(params)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "name" => "Adriel", "email" => "joao@gmail.com", "inserted_at" => _inserted_at } = response
    end

    test "when there is an error, return the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, "1234"))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"message" => "Invalid ID format!", "status" => 400}}

      assert response == expected_response
    end

    test "when there is id formart valid and id not exists, return the error", %{conn: conn} do

      response =
          conn
          |> get(Routes.users_path(conn, :show, Ecto.UUID.generate()))
          |> json_response(:not_found)

      expected_response = %{"message" => %{"message" => "User not found", "status" => 404}}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when delete a User valid, return no content", %{conn: conn} do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      {:ok, %User{id: id}} = ApiAuth.create_user(params)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))

      assert response.resp_body == ""
      assert response.status == 204
    end

    test "when there is an error, return the error", %{conn: conn} do

      response =
          conn
          |> delete(Routes.users_path(conn, :delete, "1234"))
          |> json_response(:bad_request)

      expected_response = %{"message" => %{"message" => "Invalid ID format!", "status" => 400}}

      assert response == expected_response
    end

    test "when there is id formart valid and id not exists, return the error", %{conn: conn} do

      response =
          conn
          |> delete(Routes.users_path(conn, :delete, Ecto.UUID.generate()))
          |> json_response(:not_found)

      expected_response = %{"message" => %{"message" => "User not found", "status" => 404}}

      assert response == expected_response
    end
  end

  describe "update/2" do

    setup do
      params = %{name: "Adriel", email: "joao@gmail.com", password: "123456"}

      {:ok, %User{id: id}} = ApiAuth.create_user(params)

      {:ok, user_id: id}
    end

    test "when id is valid, return the User", %{conn: conn, user_id: id} do
      params = %{name: "João", email: "joao@gmail.com", password: "123456"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:ok)

      assert %{"message" => "User updated!", "user" => %{"id" => _id, "email" => "joao@gmail.com", "inserted_at" => _inserted_at, "name" => "João", "updated_at" => _updated_at}} = response
    end

    test "when id is valid but the password is invalid, return the error", %{conn: conn, user_id: id} do
      params = %{name: "João", email: "joao@gmail.com", password: "12345"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:bad_request)

      assert response == %{"message" => %{"password" => ["should be at least 6 character(s)"]}}
    end

    test "when id is format invalid, return the error", %{conn: conn} do
      params = %{name: "João", password: "123456"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, "1234", params))
        |> json_response(:bad_request)

      assert response == %{"message" => %{"message" => "Invalid ID format!", "status" => 400}}
    end

    test "when id is format valid but User is not found, return the error", %{conn: conn} do
      params = %{name: "João", password: "123456"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, Ecto.UUID.generate(), params))
        |> json_response(:not_found)

      assert response == %{"message" => %{"message" => "User not found", "status" => 404}}
    end
  end
end
