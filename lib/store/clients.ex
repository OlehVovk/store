defmodule Store.Clients do
  import Ecto.Query
  alias Store.Client
  alias Store.Repo

  def create(%{} = params) do
    Client.changeset(%Client{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %Client{} = client <- Repo.get(Client, id) do
      Client.changeset(client, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %Client{} = client <- Repo.get(Client, id) do
      Repo.delete(client)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(Client, id)
  end

  def index(params) do
    Enum.reduce(params, Client, fn
      {"city", city}, query ->
        city = String.downcase(city)
        query |> where([c], fragment("lower(?)", c.city) == ^city)

      {"phone", phone}, query ->
        query |> where([c], like(c.phone, ^"%#{phone}%"))

      {"name", name}, query ->
        name = String.downcase(name)

        query |> where([c], fragment("lower(?) like ?", c.name, ^"%#{name}%"))

      {"birthday", year}, query ->
        {:ok, year_begining} = Date.new(year, 1, 1)
        {:ok, year_end} = Date.new(year, 12, 31)

        query
        |> where([c], c.birthday >= ^year_begining and c.birthday <= ^year_end)
        

      _, query ->
        query
    end)
    |> Repo.all()
  end
end
